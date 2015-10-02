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
      cronString: config.crontab
      noUnsubscribe: config.noUnsubscribe
      fireOnce: config.timeout?
      nodeId: config.id
      nonce: config.nanocyte?.nonce

  multiplier: (units) =>
    return 1000 if units == 'seconds'
    return 1000*60 if units == 'minutes'
    return 1000*60*60 if units == 'hours'
    return 1

module.exports = IntervalStart
