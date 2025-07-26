using DiffSim

function force_example()
    initial_pos = [0.0, 0.0]
    initial_vel = [5.0, 2.0]
    target_pos = [100.0, 50.0]
    
    thrust_needed, error = solve_constant_force(
        initial_position = initial_pos,
        initial_velocity = initial_vel,
        target_position = target_pos,
        total_time = 10.0,
        mass = 1000.0
    )
    
    println("Required force: $(round.(thrust_needed, digits=2)) N")
    println("Force magnitude: $(round(sqrt(sum(thrust_needed.^2)), digits=2)) N")
    println("Error: $(round(error, digits=6))")
    println()
end

println("Force required to move an object from the origin starting with v=[5.0, 2.0] to [100.0, 50.0]")
println("=" ^ 40)

force_example()