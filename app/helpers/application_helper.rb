# Methods added to this helper will be available to all templates in the application.

module ApplicationHelper
# Prototype Window Class Helper v0.11.0
# By Jorge Díaz - http://xurde.info 
# email: jorgedf@gmail.com
# Thanks to Sebastien Gruhier for his Prototype Window Class (http://prototype-window.xilinus.com/)
# Samples: http://pwc-helper.xurdeonrails.com
 
#Quick use:
#Reference this helper in your rails applicaction adding -> helper :prototype_window_class in your application.rb
#You must include in the template header the prototype window class javascripts and the .css theme you want to use.
#This code in your template might be enough:
 
    #  <%= stylesheet_link_tag 'default' %> (or theme you wanna use)
    #  <%= stylesheet_link_tag 'alert' %>
    #  <%= javascript_include_tag :defaults %>
    #  <%= javascript_include_tag 'window'%>
 
 

    #support methods
 
    def params_for_javascript(params) #options_for_javascript doesn't works fine
 
        '{' + params.map {|k, v| "#{k}: #{ 
            case v
              when Hash then params_for_javascript( v )
              when JsCode then v
             # when Array then...
              when String then "'#{v}'"             
            else v   #Isn't neither Hash or String
            end }"}.sort.join(', ') + '}'
    end
 
 
    def content_for_window( content ) #converts 
 
      case content
        when Hash then params_for_javascript( content )
        when String then "'#{content}'"
        else
            nil
        end
    end
 
 
    #helper methods
 
    def link_to_prototype_dialog( name, content, dialog_kind = 'alert', options = {} , html_options = {} )
 
        #dialog_kind: 'alert' (default), 'confirm' or 'info' (info dialogs should be destroyed with a javascript function call 'win.destroy')
        #options for this helper depending the dialog_kind: http://prototype-window.xilinus.com/documentation.html#alert (#confirm or #info)
 
        options.merge!( :windowParameters => {} ) if !options.has_key?(:windowParameters)
 
        js_code ="Dialog.#{dialog_kind}( #{content_for_window(content)},  #{params_for_javascript(options) } ); "
        content_tag(
               "a", name, 
               html_options.merge({ 
                 :href => html_options[:href] || "#", 
                 :onclick => (html_options[:onclick] ? "#{html_options[:onclick]}; " : "") + js_code }))
    end
 
 
 
 
    def link_to_prototype_confirm_url( name, content, ok_url, cancel_url = nil , options = {} , html_options = {} )
 
        #options for this helper: http://prototype-window.xilinus.com/documentation.html#confirm
 
        js_ok = "function(){document.location=\'#{ok_url}\';}"
        js_cancel = "function(){document.location=\'#{cancel_url}\';}"
 
        options.merge!( :ok => JsCode.new(js_ok) )
        options.merge!( :cancel => JsCode.new(js_cancel) ) if cancel_url
        options.merge!( :windowParameters => {} ) if !options.has_key?(:windowParameters)
 
        js_code = "Dialog.confirm( '#{content}',  #{params_for_javascript( options )} ); "
        content_tag(
               "a", name, 
               html_options.merge({ 
                 :href => html_options[:href] || "#", 
                 :onclick => (html_options[:onclick] ? "#{html_options[:onclick]}; " : "") + js_code }))
    end
 
  
 
    def link_to_prototype_window( name, window_id, options = {} , html_options = {} &block )
 
        #window_id must be unique and it's destroyed on window close.
        #options for this helper: http://prototype-window.xilinus.com/documentation.html#initialize
 
        options.merge!( :windowParameters => {} ) if !options.has_key?(:windowParameters)
 
        js_code ="var win = new Window( '#{window_id}', #{params_for_javascript(options) } );  win.show(); win.setDestroyOnClose();"
        content_tag(
               "a", name, 
               html_options.merge({ 
                 :href => html_options[:href] || "#", 
                 :onclick => (html_options[:onclick] ? "#{html_options[:onclick]}; " : "") + js_code }))
	
    end
############################################## From 

 def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f  

    form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end




def params_for_javascript(params) #options_for_javascript doesn't works fine
      '{' + params.map {|k, v| "#{k.to_s.camelize(:lower)}: #{ 
          case v
            when Hash then params_for_javascript( v )
            when String then "'#{v}'"          
          else v   #Isn't neither Hash or String
          end }"}.sort.join(', ') + '}'
  end
    
  def options_for_javascript_with_callbacks(options)
    callbacks_opts = options.delete(:callbacks)
    if callbacks_opts
      callbacks = options_for_javascript(callbacks_opts)
      return  opts = "#{params_for_javascript(options)},#{callbacks}"
    else
      return opts = params_for_javascript(options)
    end
  end  
  
  def enabled_button(device, control)
    image_tag(device.enabled_icon(control,:list), :border => "none", :title => control.title)
  end
  
  def disabled_button(device, control)
    image_tag(device.disabled_icon(control,:list), :border => "none", :title => control.title)
  end
  
  def icon_for_outbound(outbound, icon_kind)
    image_tag(outbound.icon_path(icon_kind), :border => "none", :title => outbound.control.title)
  end
  
  def show_onready(opts ={})
    if opts[:icon]
      link = image_tag(opts[:icon], :style => "border:none;z-index:10;", :title => opts[:title])
    else
      link = opts[:id].humanize
    end
    if opts[:show_now]
      intit_string = "win_#{opts[:id]}.show();"
    else
      intit_string = ""
    end
    if opts[:win_size]
      intit_string += "win_#{opts[:id]}.setSize(#{opts[:win_size][0]},#{opts[:win_size][1]});"
    end
    if opts[:constraint]
      intit_string += "win_#{opts[:id]}.setConstraint(true,#{options_for_javascript(opts[:constraint])});"
    end
    if opts[:location]
      intit_string += "win_#{opts[:id]}.setLocation(#{opts[:location][0]},#{opts[:location][1]});"
    end
    js = <<-JS
      <script type="text/javascript">
        var win_#{opts[:id]};
        function showWindow_#{opts[:id]}(){
          win_#{opts[:id]} = new Window( '#{opts[:window_id]}', #{opts[:js_opts]} );
          win_#{opts[:id]}.setContent('#{opts[:content_id]}', #{opts[:autoresize]},#{opts[:autoposition]});
          #{intit_string}
        }
        Event.observe(window,"load",showWindow_#{opts[:id]});
      </script>
    JS
    if opts[:show_now]
      return js
    else
      js # + link_to_function(link, "win_#{opts[:id]}.show();" )
    end
  end
  
  def create_content_div(content,content_id,html_options)
    style = "display:none;#{html_options.delete(:style)}"
    content_tag(:div, content, html_options.merge({:style => style,:id => content_id}))
  end  

  
  def prototype_window(window_id, options = {},html_options = {}, &block)
    default_options = {:autoresize => false, :autoposition => false}
    options = default_options.merge(options)
    #content_id = "#{window_id}_div_#{(rand*1e6).to_i}"
    content_id = "#{window_id}_div"
    content = create_content_div(capture(&block),content_id,html_options)
    autoresize = options.delete(:autoresize) ? true : false 
    autoposition = options.delete(:autoposition) ? true : false 
    opts = options_for_javascript_with_callbacks(options)
    content + show_onready(:id => content_id, :js_opts => opts, :window_id => window_id, :content_id => content_id, :autoposition => autoposition, :autoresize => autoresize, :icon => options[:icon], :show_now => options[:show_now], :win_size => options[:win_size], :title => options[:title], :location => options[:location], :constraint => options[:constraint])
  end
  
    
  def link_to_prototype_dialog(name, ajax_options ={}, options = {} , html_options = {} )
      content_div_name = options.delete(:content_div_name)
      opts = options_for_javascript_with_callbacks(options)
      js_code ="Dialog.info($('#{content_div_name}').innerHTML, #{opts});"
      link_to_remote(name, ajax_options.merge(:complete => js_code),html_options)
  end
 
  def ggg(id)
  @nomer=id
  return @nomer
  end


 
end
