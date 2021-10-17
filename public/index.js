
const baseLayerElements = document.querySelectorAll('#layers > b1 > div > input[type=radio]');
for(let baseLayerElement of baseLayerElements) 
{
  baseLayerElement.addEventListener('change', function() {
    let baseLayerElementValue = this.value;
    
    console.log(MapGroup.getLayers());

    MapGroup.getLayers().forEach(function(element, index, array) {
     
        //console.log(element.getKeys());
       // console.log(element);
     
        let baseLayerTitle = element.get('name');
        element.setVisible(baseLayerTitle === baseLayerElementValue);
    })
  })
}
