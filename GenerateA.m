
Tfinal = 60;         % Total duration
tss = 0.1;           % Sampling step
t = 0:tss:Tfinal;

% Air to underwater trajectory
x = 2 * sin(0.1 * t);
y = 2 - 1.5 * cos(0.1 * t);
z = [3 * ones(1,100), linspace(3, 0, 100), linspace(0, -6, length(t)-200)];

% Combine trajectory
A = [x' y' z'];

% Generate Euler angles (synthetic motion)
roll  = 10 * sin(0.1 * t);
pitch = 5 * sin(0.07 * t + 0.5);
yaw   = 20 * sin(0.05 * t + 1);
Euler = [roll; pitch; yaw];  % 3 x N

% Final output structure
out.XYZ = A';
out.EulerAngles = Euler;
out.time = t;
