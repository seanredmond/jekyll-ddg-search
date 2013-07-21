module Jekyll
  class DdgSearchTag < Liquid::Tag
 
    def initialize(tag_name, text, tokens)
      super
      @tag = tag_name
      @text = text
      
    end
 
    def render(context)
<<HTML
<iframe src="http://duckduckgo.com/search.html?prefill=Search DuckDuckGo" 
        style="overflow:hidden;margin:0;padding:0;width:408px;height:40px;" 
        frameborder="0">
</iframe>
HTML
    end
  end
end
 
Liquid::Template.register_tag('ddgsearch', Jekyll::DdgSearchTag)