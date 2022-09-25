const QBCore = exports["qb-core"].GetCoreObject();

QBCore.Commands.Add("dc3d", "Open Draw 3D Text Menu", {}, false, (source) => {
  emitNet("dcTEW:client:openMenu", source);
});

onNet("dcTEW:server:getData", (zoneName, type) => {
  const path = GetResourcePath(GetCurrentResourceName());
  const file = path + "/saves/" + zoneName + ".json";
  if (!fs.existsSync(file)) {
    return false;
  }
  data = jsonToObj(file);
  if (type == 2) {
    emitNet("dcTEW:client:showTextList", source, data);
  } else {
    emitNet("dcTEW:client:getData", source, data);
  }
});

onNet("dcTEW:server:deleteAText", (data) => {
  const uid = data.uid;
  const zoneName = data.zoneName;
  const path = GetResourcePath(GetCurrentResourceName());
  const file = path + "/saves/" + zoneName + ".json";
  let raw = jsonToObj(file);
  delete raw[uid];
  fs.writeFileSync(file, JSON.stringify(raw), (err) => {});
  emitNet("dcTEW:client:refresh", source);
  emitNet("dcTEW:Notify", source, "Delete successfully");
});
onNet("dcTEW:server:save", (data) => {
  const path = GetResourcePath(GetCurrentResourceName());
  const file = path + "/saves/" + data.zoneName + ".json";
  let config = {};
  if (fs.existsSync(file)) {
    config = jsonToObj(file);
  }
  let raw = {
    coords: data.coords,
    text: data.text,
    author: data.author,
  };

  config[data.uid] = raw;
  if (data.text) {
    fs.writeFileSync(file, JSON.stringify(config), (err) => {});
    emitNet("dcTEW:client:refresh", source);
    emitNet("dcTEW:Notify", source, "create successfully!");
  } else {
    emitNet("dcTEW:Notify", source, "Failed:No Text Contenet");
  }
});
