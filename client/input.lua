InputMenu = function(x, y, z)
  local drawTextInput = exports['qb-input']:ShowInput({
    header = "Create 3D Text",
    submitText = "Create",
    inputs = {
      {
        text = "Unique id",
        name = "uid",
        type = "text",
        isRequired = true,
      },
      {
        text = "Content",
        name = "content",
        type = "text",
        isRequired = true,
      },

    },
  })
  if drawTextInput ~= nil then
    print("null?")
    local data = {}
    data.x = x
    data.y = y
    data.z = z
    data.text = drawTextInput.content
    data.uid = drawTextInput.uid
    -- data.zoneName =
    TriggerEvent("dcTEW:client:draw", data)
  end
end
