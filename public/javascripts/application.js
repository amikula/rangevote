function setValue(input, display, v)
{
  input.value=Math.floor(v);
  display.innerHTML=Math.floor(v);

  setColorForRange(display, v);
}

function setColorForRange(element, v)
{
  element.style.backgroundColor=getColorForRange(v);
}

function zeroPad(v)
{
  retval = "";
  if(v<16) retval += "0";
  retval += v.toString(16);
  return retval;
}

function getColorForRange(v)
{
  if(v<=49) {
    red=255;
  } else {
    red=Math.floor((99-v)*(255/50.0));
  }

  if(v<=49) {
    green=Math.floor(v*(255/49.0));
  } else {
    green=255;
  }

  blue = Math.floor((49 - Math.abs(49-v))*255/49.0);
  if (blue < 0) blue = 0;

  return "#" + zeroPad(red) + zeroPad(green) + zeroPad(blue);
}
