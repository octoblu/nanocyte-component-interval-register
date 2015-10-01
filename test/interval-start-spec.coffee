ReturnValue = require 'nanocyte-component-return-value'
IntervalStart = require '../src/interval-start'

describe 'IntervalStart', ->
  beforeEach ->
    @sut = new IntervalStart

  it 'should exist', ->
    expect(@sut).to.be.an.instanceOf ReturnValue

  describe '->onEnvelope', ->
    describe 'when called with an envelope', ->
      beforeEach ->
        @result = @sut.onEnvelope
          message: 'whaaa?'
          config:
            repeat: 1000
            id: 'the-node-uuid'
            deviceId: 'some-hardcoded-uuid'
            nanocyte:
              nonce: 'i-am-a-nonce'

      it 'should return a message', ->
        expect(@result).to.deep.equal
          devices: ['some-hardcoded-uuid']
          topic: 'register-interval'
          payload:
            intervalTime: 1000
            nodeId: 'the-node-uuid'
            nonce: 'i-am-a-nonce'

    describe 'when called with an envelope, the envelope strikes back', ->
      beforeEach ->
        @result = @sut.onEnvelope
          message: '¿huuuuh!?'
          config:
            repeat: 1001
            id: 'the-edon-uuid'
            deviceId: 'some-softcoded-uuid'
            nanocyte:
              nonce: 'no-noncense'

      it 'should return a message', ->
        expect(@result).to.deep.equal
          devices: ['some-softcoded-uuid']
          topic: 'register-interval'
          payload:
            intervalTime: 1001
            nodeId: 'the-edon-uuid'
            nonce: 'no-noncense'
