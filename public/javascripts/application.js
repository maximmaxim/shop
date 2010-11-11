// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function popup(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
   href=mylink;
else
   href=mylink.href;
window.open(href, windowname, 'width=500,height=400,scrollbars=yes');
return false;
}


function davai_okno();
{
win = new Window({className: "mac_os_x", title: "Sample", width:200, height:150, destroyOnClose: true, recenterAuto:false});

win.getContent().update("<h1>Hello world !!</h1>");
win.showCenter();
}
