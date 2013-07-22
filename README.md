# DuckDuckGo Embed Search for Jekyll

Add DuckDuckGo search to your Jekyll site. 

## Installation

1. Download `ddg_search.rb` and add it to your `_plugins` directory
2. Add and configure `{% ddg_search %}` or `{% ddg_search_form %}` tags in your pages or templates.

## Usage

This plugin provides two tags. Use `{% ddg_search %}` to add an iframe-embeded search box with all the options described in the [DuckDuckGo documentation](https://duckduckgo.com/search_box). Use  `{% ddg_search_form %}` to add a form version similar to [Hardik Pandya‘s version](http://hardik.co/blog/2013/stylising-duckduckgo-site-search)

Options are passed in `key:value` pairs added to the tag, e.g.:

    {% ddg_search site:example.com prefill:Search+example.com %}

This will create a search box in an iframe that searches example.com, with the prompt text “Search example.com” in the input box.

    {% ddg_search_form site:example.com prefill:Search+example.com buttontext:Search+for+examples %}

This will create a search form similar to the previous example, with a “Search for examples” button.

## Options

DuckDuckGo provides a great deal of customization, and you can use all of their [URL parameters](https://duckduckgo.com/params) with either tag. For example `kj:g2` will cause the DuckDuckGo results page to have a green header.

The following options correspond to settings of the [DuckDuckGo search box generator](https://duckduckgo.com/search_box) for use with `ddg_search`:

* width
* duck
* site
* prefill
* bgcolor
* focus

`site` (and an alternate name `sites`) and `prefill` also work with both tags. Use `buttontext` to set the submit button text for `ddg_search_form`

The values of all options will be URL-escaped. Since `prefill` and `buttontext` may both require spaces, they are handled specially -- use ‘+‘ for spaces in both, they will be URL-escaped, but each ‘+’ will be converted back to a literal space in the output. Ex.: `prefill:Search+example.com` will generate the placeholder text “Search example.com”.

## Styling

All styling must be done by CSS. No classes or ids are added to the output, so the simplest thing to do is wrap the search in another element:

    <div class="mysearch">
        {% ddg_search site:example.com prefill:Search+example.com %}

        {% ddg_search_form site:example.com prefill:Search+example.com %}
    </div>

You can then use the selectors `.mysearch iframe` and `.mysearch form` in your site‘s CSS.

## Frameborder

`frameborder` is a deprecated attribute and, by default, is not added to the iframe markup generated by `ddg_search`. Since `frameborder=0` is fairly ubiquitous, though, use the `frameborder` option to add this.

    {% ddg_search site:example.com frameborder:0 %}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
