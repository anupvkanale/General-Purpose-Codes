function plotGen(str,velVec)
%   Fuction to generate plots for Stokeslet computation codes
    
    if strcmp(str,"direct")
        load('direct_Stokes_data');
        set(figure(1), 'Position', [0,1000, 700,700]);
        clf(figure(1))
        title('Direct Method');
    elseif strcmp(str,"ewald")
        load('ewald_Stokes_data');
        set(figure(2), 'Position', [3000,1000, 700,700]);
        clf(figure(2))
        title('Ewald method');        
    else
        disp('Invalid option');
    end

    for ii=1:nStokes
        scatter3(r_fVec(1,ii),r_fVec(2,ii),r_fVec(3,ii), 'filled'); %,'or',...
            %'markersize', 10, 'markerfacecolor', 'r');
        hold on;
    end

    % Convert to format appropriate for plotting
    u3d = zeros(nX,nY,nZ);
    v3d = zeros(nX,nY,nZ);
    w3d = zeros(nX,nY,nZ);
    velMag3d = zeros(nX,nY,nZ);
    for pointNum=1:nPoints
    kk = floor((pointNum-1)/(nX*nY)) + 1;
    jj = floor((pointNum-(kk-1)*nX*nY-1)/nX) + 1;
    ii = rem(pointNum-1,nX) + 1;
        
        u3d(ii,jj,kk) = velVec(1,pointNum);
        v3d(ii,jj,kk) = velVec(2,pointNum);
        w3d(ii,jj,kk) = velVec(3,pointNum);
        velMag3d(ii,jj,kk) = norm(velVec(:,pointNum));
    end

    % Plot flowfield in 2D
    u2d = squeeze(u3d(:,:,7)); %(nZ+1)/2));
    v2d = squeeze(v3d(:,:,7)); %(nZ+1)/2));
    % velMag2d = squeeze(velMag3d(:,:,(nZ+1)/2));

    % pcolor(rx,ry,velMag2d);
    % shading interp;
    % colorbar;
    scale = 50;
    [x,y] = meshgrid(ry,rx);
    quiv = quiver(x,y,u2d*scale,v2d*scale);
    xlim([0 L(1)]); ylim([0 L(2)]); zlim([0 L(3)]);
    quiv.Color = 'blue';
    quiv.LineWidth = 1.5;
%     axis equal;
    grid minor;
    

    % 3D plotting
    % [x,y,z] = meshgrid(rx,ry,rz);
    % quiv = quiver3(x,y,z,u3d,v3d,w3d);
    % quiv.Color = 'White';
    % quiv.LineWidth = 1.0;
    % Slice plot
    % xslice = 1;
    % yslice = 1;
    % zslice = 0.5;
    % slice(x,y,z,velMag3d,xslice,yslice,zslice)
end

