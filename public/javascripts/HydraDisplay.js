function HydraDisplay(canvasId, colorOn, colorOff, display) {

  if(display === undefined) {
    display = new SegmentDisplay(canvasId);
  }

  display.pattern         = "##.##";
  display.displayAngle    = 5.5;
  display.digitHeight     = 3.5;
  display.digitWidth      = 2;
  display.digitDistance   = 1.3;
  display.segmentWidth    = 0.2;
  display.segmentDistance = 0.3;
  display.segmentCount    = 7;
  display.cornerType      = 3;
  display.colorOn         = colorOn;
  display.colorOff        = colorOff;
  display.draw();

  var channel = canvasId.slice(0, -1);
  var measures = canvasId.substr(-1 ,1);

  return {
    display: display,
    channel: channel,
    measures: measures
  };
}

function setupDisplay(serverURL, displayOpts){
  (function poll(){
    $.ajax({ url: serverURL + '/' + displayOpts.channel + '/' + displayOpts.measures, success: function(data, displayOpts){
      displayOpts.display.setValue("99.99")
    }, dataType: "json", complete: poll, timeout: 30000 });
  })();
}

function setupSlider(sliderId) {
  $(document).ready(function () {
    sliderId.forEach(function(e){
      $(e).jqxSlider({ theme: 'summer', value: 7 });
    })
  });
}
