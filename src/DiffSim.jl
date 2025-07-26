module DiffSim

using ForwardDiff
using Optim

export solve_initial_velocity, solve_constant_force, simulate_forward
export ConstantForce, LinearDrag

abstract type Force end

struct ConstantForce{T} <: Force
    force::Vector{T}
end

struct LinearDrag{T} <: Force
    coefficient::T
end

function apply_force(f::ConstantForce, pos, vel, t)
    return f.force
end

function apply_force(f::LinearDrag, pos, vel, t)
    return -f.coefficient * vel
end

function step(pos, vel, forces, dt, t, mass=1.0)
    total_force = sum(f -> apply_force(f, pos, vel, t), forces)
    acceleration = total_force / mass
    new_vel = vel + acceleration * dt
    new_pos = pos + vel * dt
    return new_pos, new_vel
end

function simulate_forward(initial_pos, initial_vel, forces, dt, total_time; mass=1.0)
    pos, vel = initial_pos, initial_vel
    t = 0.0
    while t < total_time
        pos, vel = step(pos, vel, forces, dt, t, mass)
        t += dt
    end
    return pos
end

function solve_initial_velocity(;
    initial_position,
    target_position, 
    forces,
    total_time,
    dt = 0.01,
    mass = 1.0
)
    function loss(initial_vel)
        final_pos = simulate_forward(initial_position, initial_vel, forces, dt, total_time; mass=mass)
        return sum((final_pos - target_position).^2)
    end
    function grad!(g, x)
        g .= ForwardDiff.gradient(loss, x)
    end
    initial_guess = (target_position - initial_position) / total_time
    result = optimize(loss, grad!, initial_guess, LBFGS())
    return Optim.minimizer(result), Optim.minimum(result)
end

function solve_constant_force(;
    initial_position,
    initial_velocity,
    target_position,
    total_time,
    dt = 0.01,
    mass = 1.0
)
    function loss(force_vec)
        forces = [ConstantForce(force_vec)]
        final_pos = simulate_forward(initial_position, initial_velocity, forces, dt, total_time; mass=mass)
        return sum((final_pos - target_position).^2)
    end
    function grad!(g, x)
        g .= ForwardDiff.gradient(loss, x)
    end
    n_dim = length(initial_position)
    initial_guess = zeros(n_dim)
    result = optimize(loss, grad!, initial_guess, LBFGS())
    return Optim.minimizer(result), Optim.minimum(result)
end

end