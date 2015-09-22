ReturnValue = require 'nanocyte-component-return-value'

class IntervalStart extends ReturnValue
  onEnvelope: (envelope) =>
    return envelope.message

module.exports = IntervalStart
