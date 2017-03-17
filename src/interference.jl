# Visualization of the interference of two point sources in 2D

using PyPlot

const L = 6
const sep = 2
const N = 500
const k = 5

V = linspace(-L, L, N)
X = V
Y = X'
#X, Y = meshgrid(V, V)
R1 = sqrt( (X.-sep).^2 .+ Y.^2)
R2 = sqrt( (X.+sep).^2 .+ Y.^2)

# Sum of Green's functions for two point sources
Z = exp(1im*k*R1)./R1 + exp(1im*k*R2)./R2

M = 10
T = linspace(0.0, 2*pi, M)
T = T[1:(M-1)]
cut = 0.8
scale = 55/(2*cut)


for p=1:1
  for iter=1:length(T)

    figure(1)
    clf()
    hold()

    W = real(Z*exp(-1im * T[iter]))
    W = max(W, -cut)
    W = min(W, cut)

    imshow(scale*(W+cut), vmin=nothing, vmax=nothing, aspect="equal")

    filename = "Frame$(1000+iter)"
    print("Saving to $(filename)")
    savefig(filename)
  end
 end

 # convert to gif
 run(`convert -density 100 -loop 1000 -delay 10 Frame100* interference_two_sources.gif`)
