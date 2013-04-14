# mruby-pid

A PID algorithm library based on [Temper](https://github.com/cadwallion/temper) for mruby.

## Installation

Mruby uses mrbgems, which adds gems into the compilation process.  Add the following to your
`build_config.rb` in the mruby source directory:

```
config.gem :github => 'cadwallion/mruby-pid'
```

Run `make` or `./minirake` in the mruby source directory and mruby-pid will be added.

## Usage

A PID controller is based on four values: 

* kp - Proportional Tuning Parameter
* ki - Integral Tuning Parameter
* kd - Derivative Tuning Parameter
* setpoint - target temperature

The `PID` class can either be initialized with the kp/ki/kd values, or tuned after initialization

``` ruby
pid1 = PID.new :kp => 1.0, :ki => 1.0, :kd => 1.0
pid1.setpoint = 200.0

pid2 = PID.new
pid2.tune 1.0, 1.0, 1.0
pid2.setpoint = 200.0
```
Once created, the heart of the PID library is in the `PID#control` method.  Pass this method the
current temperature, and it will use the modified PID algorithm to output a power level.  Use 
this value to adjust your heating/cooling control based on the power.

``` ruby
pid = PID.new :kp => 1.0, :ki => 1.0, :kd => 1.0
pid.setpoint = 185.5

power_level = pid.control 95.0
```
For some systems, there is an upperbound to PWM control values (for example, the Arduino PWM 
values cannot exceed 255). The PID's minimum and maximum can be set with the `:maximum` and
`:minimum` options at initialization.

## Examples

See the [examples](examples/) directory for common applications of the mruby-pid library.
