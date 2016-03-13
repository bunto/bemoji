require 'spec_helper'

RSpec.describe(Bunto::Emoji) do
  Bunto.logger.log_level = :error

  let(:config_overrides) { {} }
  let(:configs) do
    Bunto.configuration(config_overrides.merge({
      'skip_config_files' => false,
      'collections'       => { 'docs' => { 'output' => true }, 'secret' => {} },
      'source'            => fixtures_dir,
      'destination'       => fixtures_dir('_site')
    }))
  end
  let(:emoji)       { described_class }
  let(:site)        { Bunto::Site.new(configs) }
  let(:default_src) { "https://assets.github.com/images/icons/" }
  let(:result)      { "<img class=\"emoji\" title=\":+1:\" alt=\":+1:\" src=\"#{default_src}emoji/unicode/1f44d.png\" height=\"20\" width=\"20\" align=\"absmiddle\">" }

  let(:posts)        { site.posts.docs }
  let(:basic_post)   { find_by_title(posts, "Refactor") }
  let(:complex_post) { find_by_title(posts, "Code Block") }

  let(:basic_doc) { find_by_title(site.collections["docs"].docs, "File") }
  let(:doc_with_liquid) { find_by_title(site.collections["docs"].docs, "With Liquid") }
  let(:txt_doc) { find_by_title(site.collections["docs"].docs, "Don't Touch Me") }

  def para(content)
    "<p>#{content}</p>\n"
  end

  before(:each) do
    site.read
    (site.pages + posts + site.docs_to_write).each { |p| p.content.strip! }
    site.render
  end

  it "creates a filter" do
    expect(emoji.filters[default_src]).to be_a(HTML::Pipeline)
  end

  it "has a default source" do
    expect(emoji.emoji_src).to eql(default_src)
  end

  it "correctly replaces the emoji with the img in posts" do
    expect(basic_post.output).to eql(para(result))
  end

  it "doesn't replace emoji in a code block" do
    expect(complex_post.output).to include(
      "<span class=\"s2\">\":smile: every day\"</span>"
    )
    expect(complex_post.output).to include(result)
  end

  it "correctly replaces the emoji with the img in pages" do
    expect(site.pages.first.output).to eql(para(result))
  end

  it "correctly replaces the emoji with the img in collection documents" do
    expect(basic_doc.output).to eql(para(result))
  end

  it "leaves non-HTML files alone" do
    expect(txt_doc.output).to eql(":+1:")
  end

  it "does not replace the emoji if the collection document is not to be output" do
    expect(site.collections["secret"].docs.first.output).to eql(para(":+1:"))
  end

  it "does not mangle liquid templates" do
    expect(doc_with_liquid.output).to eql(
      para("#{result} <a href=\"/docs/with_liquid.html\">_docs/with_liquid.md</a>")
    )
  end

  context "with a different base for jemoji" do
    let(:emoji_src) { "http://mine.club/" }
    let(:config_overrides) do
      {
        "emoji" => { "src" => emoji_src }
      }
    end

    it "fetches the custom base from the config" do
      expect(emoji.emoji_src(site.config)).to eql(emoji_src)
    end

    it "respects the new base when emojifying" do
      expect(basic_post.output).to eql(para(result.sub(default_src, emoji_src)))
    end
  end
end
