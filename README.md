# DiffSim.jl

A simple Julia package for differentiable particle simulation and inverse problem solving.

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/yashnator/DiffSim.jl")
```

Or for clone and use the following command:

```julia
using Pkg
Pkg.develop(path="/path/to/DiffSim.jl")
```

## Quick Start

```julia
using DiffSim

# Problem: Hit a target with projectile motion
initial_pos = [0.0, 0.0]
target_pos = [10.0, 5.0]
gravity = ConstantForce([0.0, -9.81])

# Find required initial velocity
initial_vel, error = solve_initial_velocity(
    initial_position = initial_pos,
    target_position = target_pos,
    forces = [gravity],
    total_time = 2.0
)

println("Required velocity: $initial_vel m/s")
```

## API Reference

#### `solve_initial_velocity`
Find the initial velocity needed to reach a target position.

```julia
solve_initial_velocity(;
    initial_position,    # Starting position vector
    target_position,     # Desired final position vector  
    forces,             # Vector of Force objects
    total_time,         # Time to reach target
    dt = 0.01,          # Integration time step
    mass = 1.0          # Particle mass
) -> (initial_velocity, error)
```

#### `solve_constant_force`
Find the constant force needed to reach a target position.

```julia
solve_constant_force(;
    initial_position,    # Starting position vector
    initial_velocity,    # Starting velocity vector
    target_position,     # Desired final position vector
    total_time,         # Time to reach target
    dt = 0.01,          # Integration time step  
    mass = 1.0          # Particle mass
) -> (force_vector, error)
```

#### `simulate_forward`
Forward simulation for verification.

```julia
simulate_forward(initial_pos, initial_vel, forces, dt, total_time; mass=1.0)
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.