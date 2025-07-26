using Pkg
Pkg.develop(path="/Users/yashsolanki/Desktop/opensource/DiffSim.jl")

using DiffSim

function basketball_shot()
    # Objective: Move particle from origin at [7.0, 3.0] in 1.2 seconds
    initial_pos = [0.0, 2.0]
    target_pos = [7.0, 3.0]
    gravity = ConstantForce([0.0, -9.81])
    
    initial_vel, error = solve_initial_velocity(
        initial_position = initial_pos,
        target_position = target_pos,
        forces = [gravity],
        total_time = 1.2
    )
    
    println("Required shot velocity: $(round.(initial_vel, digits=2)) m/s")
    println("Error: $(round(error, digits=6))")
    final_pos = simulate_forward(initial_pos, initial_vel, [gravity], 0.01, 1.2)
    println("Actual landing: $(round.(final_pos, digits=2))")
    println()
end

println("Velocity required to move a particle to given position")
println("=" ^ 40)

basketball_shot()