import xml.etree.ElementTree as ET

data = list()
for i in range(10):
    print(i+1)
    data.append("/home/ender/Desktop/AIDEdevelopment/e" + str(i + 1) + "interview/src/main/spec/specification.xml")

    tree = ET.parse(data[i])
    root = tree.getroot()
    keys = root.findall("./models/model/object")

    for key in keys:
        if (key.attrib["type"] == "ingenias.editor.entities.SimulationDiagramDataEntity"):
            print(key.attrib["id"])
            simDescs = key.findall("./mapproperties/key")
            for desc in simDescs:
                if (desc.attrib["id"] == "Description"):
                    if ((desc.text != "Yes") & 
                        (desc.text != "INGENIAS") & 
                        (desc.text is not None)):
                        print(desc.text)
        