
figure;
xlimit = [-5 5]; ylimit = [-5 5]; zlimit = [-7 5];
NewFigure(xlimit, ylimit, zlimit, -30, 18, 600, 600);
pause(1);

% Run animation
AniEulerTar(out.time, out.XYZ, out.EulerAngles, []);

%% Plot XYZ vs Time
figure;
subplot(3,1,1); plot(out.time, out.XYZ(1,:)'); xlabel('time'); ylabel('X Pos');
subplot(3,1,2); plot(out.time, out.XYZ(2,:)'); xlabel('time'); ylabel('Y Pos');
subplot(3,1,3); plot(out.time, out.XYZ(3,:)'); xlabel ('time'); ylabel('Z Pos');

%% Support Function
function NewFigure(xlim, ylim, zlim, viewx, viewy, w, h)
    set(gca, 'XLim', xlim, 'YLim', ylim, 'ZLim', zlim);
    view(viewx, viewy);
    set(gcf, 'Position', [10, 10, w, h]);2
    hold on; grid on;
end
