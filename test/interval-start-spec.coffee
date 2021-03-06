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
              cronString: undefined
              nodeId: 'the-node-uuid'
              nonce: 'i-am-a-nonce'
              noUnsubscribe: undefined

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
              cronString: undefined
              nodeId: 'the-edon-uuid'
              nonce: 'no-noncense'
              noUnsubscribe: undefined

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
              cronString: undefined
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'
              noUnsubscribe: undefined

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
              intervalTime: 39960000
              cronString: undefined
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'
              noUnsubscribe: undefined

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
              intervalTime: 666000
              cronString: undefined
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'
              noUnsubscribe: undefined

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
              intervalTime: 2397600000
              cronString: undefined
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'
              noUnsubscribe: undefined

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
              cronString: undefined
              fireOnce: true
              nodeId: 'the-node-uuid'
              nonce: 'scalding-whistle'
              noUnsubscribe: undefined

    describe 'with crontab', ->
      describe 'when called with an envelope', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'garblegarblegarble'
            config:
              crontab: 'somecrontab'
              id: 'what-node-uuid'
              deviceId: 'some-weird-hardcoded-uuid'
              nanocyte:
                nonce: 'terrible-jaws'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-weird-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: NaN
              cronString: 'somecrontab'
              fireOnce: false
              nodeId: 'what-node-uuid'
              nonce: 'terrible-jaws'
              noUnsubscribe: undefined

      describe 'when called with a different crontab', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'warblewarblewarble'
            config:
              crontab: 'some-super-cool-crontab'
              id: 'fab-node-uuid'
              deviceId: 'some-extra-weird-hardcoded-uuid'
              nanocyte:
                nonce: 'a-shrill-figment'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-extra-weird-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: NaN
              cronString: 'some-super-cool-crontab'
              fireOnce: false
              nodeId: 'fab-node-uuid'
              nonce: 'a-shrill-figment'
              noUnsubscribe: undefined

    describe 'with noUnsubscribe', ->
      describe 'when called with an envelope', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'garblegarblegarble'
            config:
              crontab: 'somecrontab'
              noUnsubscribe: true
              id: 'what-node-uuid'
              deviceId: 'some-weird-hardcoded-uuid'
              nanocyte:
                nonce: 'terrible-jaws'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-weird-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: NaN
              cronString: 'somecrontab'
              fireOnce: false
              nodeId: 'what-node-uuid'
              nonce: 'terrible-jaws'
              noUnsubscribe: true

      describe 'when called with a different crontab', ->
        beforeEach ->
          @result = @sut.onEnvelope
            message: 'warblewarblewarble'
            config:
              crontab: 'some-super-cool-crontab'
              noUnsubscribe: true
              id: 'fab-node-uuid'
              deviceId: 'some-extra-weird-hardcoded-uuid'
              nanocyte:
                nonce: 'a-shrill-figment'

        it 'should return a message', ->
          expect(@result).to.deep.equal
            devices: ['some-extra-weird-hardcoded-uuid']
            topic: 'register-interval'
            payload:
              intervalTime: NaN
              cronString: 'some-super-cool-crontab'
              fireOnce: false
              nodeId: 'fab-node-uuid'
              nonce: 'a-shrill-figment'
              noUnsubscribe: true
