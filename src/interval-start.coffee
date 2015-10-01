ReturnValue = require 'nanocyte-component-return-value'

class IntervalStart extends ReturnValue
  onEnvelope: (envelope) =>
    {config} = envelope

    devices: [config.deviceId]
    topic: 'register-interval'
    payload:
      intervalTime: config.repeat
      nodeId: config.id
      nonce: config.nanocyte?.nonce

module.exports = IntervalStart
