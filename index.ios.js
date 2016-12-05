
import {
  NativeModules
} from 'react-native'

const { OnfidoManager } = NativeModules
const Onfido = promisifyObj(OnfidoManager)

// borrowed from jest-cli

function promisifyFn (fn) {
  return function () {
    const args = Array.prototype.slice.call(arguments)
    return new Promise((resolve, reject) => {
      args.push((err, res) => {
        if (err) {
          reject(err)
        } else {
          resolve(res)
        }
      })

      fn.apply(this, args)
    })
  }
};

function promisifyObj (obj) {
  const promisified = {}
  Object.keys(obj).forEach(k => {
    const v = obj[k]
    if (typeof v === 'function') {
      promisified[k] = promisifyFn(v.bind(obj))
    } else {
      promisified[k] = v
    }
  })

  return promisified
}
