ReturnValue = require 'nanocyte-component-return-value'

class IntervalStart extends ReturnValue
  onEnvelope: (envelope) =>
    {config} = envelope

    devices: [config.deviceId]
    topic: 'register'
    payload:
      repeat: config.repeat
      nodeId: config.nodeId

module.exports = IntervalStart
