function GayaGravitasi_ForceGMm()
% clc, clear, clf

% =================
% Initialize SETUP
% =================
% Figure Properties
% 'Position',[left bottom width height]
set(gcf,'units','normal','position',[.2 .2 .5 .5], ...
    'KeyPressFcn',@f_keyPress,'color', [1 1 1]);

% Axis Properties
bound = [0 100 0 100];
set(gca,'color','black', ...
    'XLim',[bound(1) bound(2)],'YLim',[bound(3) bound(4)], ...
    'XTick',[],'YTick',[],'nextplot','add')
daspect([1 1 1])
box on

% NPM 05 Huruf F
% Generate BLOCK
global posX posY;
posX = 0; posY = 0;
posXm2 = bound(2)/2; posYm2 = bound(4)/2;
objX = [0 0 4 4 1 1 3 3 1 1];
objY = [0 6 6 5 5 4 4 3 3 0];
blockVertices = @(x,y) [objX'+x objY'+y];
blockObj = patch('Vertices', blockVertices(posX,posY), ...
    'Faces',[1 2 3 4 5 6 7 8 9 10], 'FaceColor', [mod(0,2) mod(5,2) mod(05,2)]);
blockObjM = patch('Vertices', blockVertices(posXm2,posYm2), ...
    'Faces',[1 2 3 4 5 6 7 8 9 10],'FaceColor', [0 .5 1]);

% =================
% MAIN LOOP
% =================
global vx vy G;
vx = 0; vy = 0;
G = 0; m1 = 1; m2 = 1e3;
dt = 1.0;
while 0 < 1
    tic;

    % Movement
    rx = (posX - posXm2);
    ry = (posY - posYm2);
    r = sqrt(rx^2 + ry^2);
    Fx = G*m2*rx/r^3;
    Fy = G*m2*ry/r^3;
    vx = vx - Fx/m1*dt;
    vy = vy - Fy/m1*dt;
    posX = posX + vx;
    posY = posY + vy;

    % Boundary Conditions
    if (posX < bound(1)) || (posX > bound(2))
        vx = -vx;
    end
    if (posY < bound(3)) || (posY > bound(4))
        vy = -vy;
    end

    % Update Object Coordinate
    set(blockObj,'Vertices',blockVertices(posX,posY));
    set(blockObjM,'Vertices',blockVertices(posXm2,posYm2));

    pause(1/60 - toc); % 60 fps
end
end

% =========================================================================
function f_keyPress(~,event)
global posX posY vx vy G

switch event.Key
    case 'leftarrow'
        vx = vx - 1;
        vy = vy;
    case 'rightarrow'
        vx = vx + 1;
        vy = vy;
    case 'uparrow'
        vx = vx;
        vy = vy + 1;
    case 'downarrow'
        vx = vx;
        vy = vy - 1;
    case 'space'
        vx = 0;
        vy = 0;
    case 'r'
        posX = 0;        posY = 0;
        G = 0;
    case 'g'
        G = 1.0e-1;

end

end