require "cgi"

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
      parsed_opts = Hash[opt_string.split(/\s+/).map{|opt| opt.split(':')}].
        delete_if{|k, v| (!@valid_options.include?(k)) || (v == nil) }.
        map{|k,v| "#{k}=#{escape_options(k, v)}"}.join('&amp;')
    end

    # Escape query parameters, with special handling for prefill option
    #
    # Since prefill is a prompt phrase, it will probably require spaces. In the
    # tag, spaces need to be entered as '+' so the tag options can be split
    # correctly. Pluses are then escaped as '%2B' which are finally converted
    # back to spaces.
    #
    # It would be better if DuckDuckGo handled escaped spaces better in their
    # form generation.
    def escape_options(key, value)
      value = CGI::escape(value)
      if key == 'prefill'
        value.gsub!('%2B', ' ')
      end

      return value
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
 
Liquid::Template.register_tag('ddg_search', Jekyll::DdgSearchTag)