import xml.etree.ElementTree as ET

data = list()
for i in range(7):
    print(i+1)
    data.append("/home/ender/Desktop/AIDEdevelopment/e" + str(i + 1) + "interview/src/main/spec/specification.xml")

    tree = ET.parse(data[0])
    root = tree.getroot()
    keys = root.findall("./objects/object/mapproperties/key")

    for key in keys:
        if (key.attrib["id"] == "Description"):
            if ((key.text != "Yes") & 
                (key.text != "INGENIAS") & 
                (key.text is not None)):
                print(key.text)