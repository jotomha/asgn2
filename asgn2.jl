# Part 1 --> Will need to be put into a PDF file, i just put it here so that we could both access it through the github rn

# 1: Record a video in which you prove the independence-dimension inequality.
# 
# Link: TODO INSERT HERE

# 2: Spaghetti Stick Orthogonal Projection
#
# TODO

# 3: 
#
# (i): ||a|| = 5 ; ||b|| = 3 ; ||c|| = 4
# (ii): aᵀb = 9
# (iii): b̂ = 9/5
# (iv): θ = arccos(9/15)
# (v): bᵀa/||b|| is the orthogonal projection of a onto b, whereas aᵀb/||a|| 
# is the orthogonal projection of b onto a.

# 4:
# 
# (a) Let m₁ ... mₖ be coefficients such that m₁c₁ + ... + mₖcₖ = 0. This can be 
# expanded as [m₁a₁ + ... + mₖaₖ; m₁b₁ + ... + mₖbₖ] = 0. Since a₁ ... aₖ is known
# to be linearly independent, m₁ = ... = mₖ = 0. Therefore, c₁ ... cₖ must be linearly independent.
# (b) Following the same logic as part (a), you cannot determine with certainty that c₁ ... cₖ are 
# linearly independent. If vectors b₁ ... bₖ are linearly independent, then so is c₁ ... cₖ.

# 5: 
# bᵀ(a - γb) = 0
# bᵀa - bᵀγb = 0
# bᵀa = γbᵀb
# γ||b||² = bᵀa
# γ = bᵀa / ||b||²


# Part 2      to calvin: if it says that package GLM is not installed, just activate the project by going into package mode and then activate .
using Random, GLM, DataFrames, CSV

function regress_orthogonalize(Y, x)
    N, p = size(x)
    z = copy(x)
    
    for j in 1:p
        for k in 1:(j-1)
            γ = (z[:,j]' * z[:,k]) / (z[:,k]' * z[:,k])
            z[:,j] .-= γ .* z[:,k]
        end
    end
    
    γ_last = (z[:,p]' * Y) / (z[:,p]' * z[:,p])
    return γ_last[1] # Extract the scalar from the 1x1 array
end

# Question 1
mtcars = DataFrame(CSV.File("mtcars.csv"))  # Convert csv data into dataframe
ols_est = lm(@formula(mpg ~ wt + hp), mtcars)
coefficients = coeftable(ols_est)  # Included in GLM package
println("hp coefficient: ", coefficients.cols[1][3])

# Interpretation: I have absolutely no idea what this means.


# Question 2
y = vec(mtcars.mpg) # Directly accessing a column returns in array format, i just opted to convert to vector, which probably isn't necessary
x = [ones(32) vec(mtcars.wt) vec(mtcars.hp)]
regression = regress_orthogonalize(y, x)  
print("Regression: ", regression)  # returns almost the same number! is this correct?? Unclear


# Question 3

# Question 4

# Question 5

# Question 6

# Question 7

