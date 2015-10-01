ReturnValue = require 'nanocyte-component-return-value'
IntervalStart = require '../src/interval-start'

describe 'IntervalStart', ->
  beforeEach ->
    @sut = new IntervalStart

  it 'should exist', ->
    expect(@sut).to.be.an.instanceOf ReturnValue

  describe '->onEnvelope', ->
    describe 'with repeat', ->
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
              fireOnce: false
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
              fireOnce: false
              intervalTime: 1001
              nodeId: 'the-edon-uuid'
              nonce: 'no-noncense'

    describe 'with timeout', ->
      describe 'when called with an envelope', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'whaaa?'
            config:
              timeout: 666
              id: 'the-node-uuid'
              deviceId: 'some-hardcoded-uuid'
              nanocyte:
                nonce: 'scalding-whistle'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: 666
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'

    describe 'with timeout and timeoutUnits', ->
      describe 'when called with an envelope', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'whaaa?'
            config:
              timeout: 666
              timeoutUnits: 'minutes'
              id: 'the-node-uuid'
              deviceId: 'some-hardcoded-uuid'
              nanocyte:
                nonce: 'scalding-whistle'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: 2397600
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'

      describe 'when called with seconds', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'whaaa?'
            config:
              timeout: 666
              timeoutUnits: 'seconds'
              id: 'the-node-uuid'
              deviceId: 'some-hardcoded-uuid'
              nanocyte:
                nonce: 'scalding-whistle'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: 39960
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'

      describe 'when called with hours', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'whaaa?'
            config:
              timeout: 666
              timeoutUnits: 'hours'
              id: 'the-node-uuid'
              deviceId: 'some-hardcoded-uuid'
              nanocyte:
                nonce: 'scalding-whistle'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: 143856000
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'

      describe 'when called with milliseconds', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'whaaa?'
            config:
              timeout: 666
              timeoutUnits: 'milliseconds'
              id: 'the-node-uuid'
              deviceId: 'some-hardcoded-uuid'
              nanocyte:
                nonce: 'scalding-whistle'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: 666
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'
