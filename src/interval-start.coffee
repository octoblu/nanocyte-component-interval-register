ReturnValue = require 'nanocyte-component-return-value'

class IntervalStart extends ReturnValue
  onEnvelope: (envelope) =>
    {config} = envelope

    intervalTime = config.repeat ? config.timeout
    intervalTime *= @multiplier config.timeoutUnits

    devices: [config.deviceId]
    topic: 'register-interval'
    payload:
      intervalTime: intervalTime
      fireOnce: config.timeout?
      nodeId: config.id
      nonce: config.nanocyte?.nonce

  multiplier: (units) =>
    return 60 if units == 'seconds'
    return 60*60 if units == 'minutes'
    return 60*60*60 if units == 'hours'
    return 1

module.exports = IntervalStart
