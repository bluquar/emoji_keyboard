// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let bundle = NSBundle.mainBundle()
let path = bundle.pathForResource("associations", ofType: "txt")

bundle.description

var x = NSBundle.allBundles()
x
x.count

var y = x[0]

y.pathForResource("associations", ofType: "txt")

