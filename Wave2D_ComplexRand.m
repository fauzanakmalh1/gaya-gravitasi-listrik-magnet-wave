clc, clear, close all

filename = 'Wave2D_ComplexRand.gif';
dtGIF = 0.1;   % Waktu delay penampilan

N = 2e2;

[X,Y] = meshgrid(linspace(-4*pi,4*pi,N));

figure,
set(gcf,'Color','w')

nWave = round(10*rand);
a = 5*randn(1,nWave);
k = 3*rand(1,nWave);
omega = randn(1,nWave);

dt = 0.1;

nn = 1;
for t = 0:dt:10
    Ztot = zeros(N,N);
    for ii = 1:nWave
        R = sqrt((X-a(ii)).^2 + (Y-a(ii)).^2);
        Z = sin(k(ii)*R - omega(ii)*t)./R;
        Ztot = Ztot + Z;
    end

    surf(X,Y,Ztot, ...
        'FaceColor','r', ...
        'FaceAlpha',1.0, ...
        'FaceLighting','gouraud', ...
        'LineStyle','none')
    camlight headlight

    set(gca,'FontSize',14,'LineWidth',2.0)
    axis tight
    axis([min(X(:)) max(X(:)) min(Y(:)) max(Y(:)) -2 2])
    grid off
    axis off
    view(-100,45)

    drawnow

    frame = getframe(1);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if nn == 1;
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',dtGIF);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',dtGIF);
    end
    nn = nn + 1;
end