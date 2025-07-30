
N = size(XYZ,1);
time = linspace(0, 60, N);                     % Match Tfinal in GenerateA.m
roll = 10 * sin(0.1 * time);                   % Smooth rolling
pitch = 5 * sin(0.07 * time + 0.5);            % Gentle pitching
yaw = 20 * sin(0.05 * time + 1);               % Slowly turning

EulerAngles = [roll; pitch; yaw];              % 3 x N matrix

% Save outputs into a structure for animation
out.time = time;
out.XYZ = XYZ';                                % Transpose to 3 x N
out.EulerAngles = EulerAngles;

% Optional: Plot path
figure;
plot3(XYZ(:,1), XYZ(:,2), XYZ(:,3), 'k');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Drone Path (Preview)');
grid on;
axis equal;
