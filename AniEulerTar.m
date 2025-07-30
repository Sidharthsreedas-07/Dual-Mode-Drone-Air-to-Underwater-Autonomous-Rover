function AniEulerTar(time, XYZ, EulerAngles, ~)
% 6-DOF Drone Animation with Body Axis
% INPUTS:
%   time         - 1 x N time vector
%   XYZ          - 3 x N matrix of positions [X; Y; Z]
%   EulerAngles  - 3 x N matrix of [Roll; Pitch; Yaw] in degrees
%   (Velocity input is unused, use ~)

% === Setup the Figure ===
figure;
axis equal;
xlim([-5 5]);
ylim([-5 5]);
zlim([-7 7]);
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
view(3);
title('Drone Path Simulation');
hold on;

% === Add realistic water surface ===
[xWater, yWater] = meshgrid(-5:0.1:5, -5:0.1:5);
zWater = 0;
surf(xWater, yWater, zWater * ones(size(xWater)), ...
    'FaceColor', [0.4 0.7 1], 'EdgeColor', 'none', ...
    'FaceAlpha', 0.4, 'DiffuseStrength', 0.6, 'SpecularStrength', 0.1);
lightangle(-45, 30);
lighting gouraud;
material dull;

% Plot full path
plot3(XYZ(1,:), XYZ(2,:), XYZ(3,:), 'k--');

% Initialize drone visuals
droneBody = plot3(0, 0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
xAxis = plot3([0 0], [0 0], [0 0], 'r', 'LineWidth', 2);
yAxis = plot3([0 0], [0 0], [0 0], 'g', 'LineWidth', 2);
zAxis = plot3([0 0], [0 0], [0 0], 'b', 'LineWidth', 2);

% === Animation Loop ===
step = 5;
for k = 1:step:length(time)
    pos = XYZ(:,k);

    % Euler Angles (roll, pitch, yaw)
    phi   = deg2rad(EulerAngles(1,k));
    theta = deg2rad(EulerAngles(2,k));
    psi   = deg2rad(EulerAngles(3,k));

    % Rotation Matrix (Z-Y-X)
    Rz = [cos(psi), -sin(psi), 0;
          sin(psi),  cos(psi), 0;
               0 ,        0 , 1];
    Ry = [cos(theta), 0, sin(theta);
                 0  , 1,     0;
         -sin(theta), 0, cos(theta)];
    Rx = [1,     0     ,      0;
          0, cos(phi), -sin(phi);
          0, sin(phi),  cos(phi)];
    R = Rz * Ry * Rx;

    % Axis vectors
    len = 0.5;
    Xb = R * [len; 0; 0];
    Yb = R * [0; len; 0];
    Zb = R * [0; 0; len];

    % Update visuals
    set(droneBody, 'XData', pos(1), 'YData', pos(2), 'ZData', pos(3));
    set(xAxis, 'XData', [pos(1), pos(1)+Xb(1)], 'YData', [pos(2), pos(2)+Xb(2)], 'ZData', [pos(3), pos(3)+Xb(3)]);
    set(yAxis, 'XData', [pos(1), pos(1)+Yb(1)], 'YData', [pos(2), pos(2)+Yb(2)], 'ZData', [pos(3), pos(3)+Yb(3)]);
    set(zAxis, 'XData', [pos(1), pos(1)+Zb(1)], 'YData', [pos(2), pos(2)+Zb(2)], 'ZData', [pos(3), pos(3)+Zb(3)]);

    pause(0.3);
    drawnow;
end

end
