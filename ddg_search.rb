module Jekyll
  class DdgSearchTag < Liquid::Tag
 
    def initialize(tag_name, text, tokens)
      super
      @tag = tag_name
      @text = text
      @search_url = 'http://duckduckgo.com/search.html'
      @valid_options = ['width', 'duck', 'site', 'prefill', 'bgcolor', 'focus']
      @options = get_options(text)
    end
 
    # Parse options from text string key:var pairs
    #
    # Valid options:
    #   width: Width of search box (not iframe!) in px
    #   duck: Show Duck Duck Go logo? Use 'yes', but any value turns the logo on
    #   site: Site to search
    #   prefill: Prompt text to include in search box. Use '+' for spaces
    #   bgcolor: Hex-encoded color value for search form background
    #   focus: Give search input focus when page is loaded? Use 'yes' bu any 
    #          value turns this option on
    #
    # Options with invalid keys or nil values are removed
    def get_options(opt_string)
      return Hash[opt_string.split(/\s+/).map{|opt| opt.split(':')}].
        delete_if{|k, v| (!@valid_options.include?(k)) || (v == nil) }.
        map{|k,v| "#{k}=#{v.gsub('+', ' ')}"}.join('&amp;')
    end

    def render(context)
      url = [@search_url, @options].join('?')
<<HTML
<iframe src="#{url}" 
        frameborder="0"></iframe>
</iframe>
HTML
    end
  end
end
 
Liquid::Template.register_tag('ddgsearch', Jekyll::DdgSearchTag)