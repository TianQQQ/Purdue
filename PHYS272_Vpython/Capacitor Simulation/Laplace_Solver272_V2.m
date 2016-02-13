%Laplace_Solver
%This program solves for electrostatic potential on a 2D grid using the
%method of relaxation.
%                                           D. Craig    2009

%CP -DAVID BLASING

fracunc = zeros(1,16);
showrelaxation = 1;
d = 2; %Plate seperation distance (cm)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Section 1: Setting up the grid to do the averaging on, 1 grid unit = 1 cm 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gridsize=.25;               
gridx=-10.:gridsize:10.;    
gridy=-10.:gridsize:10.;    
nx=length(gridx);           
ny=length(gridy);           

Vsol=zeros(ny,nx);          
V_init=zeros(ny,nx);       

fpts=zeros(ny,nx);          % Makes an empty array of indicators for which 
                            % points are free to vary as they are averaged
                            % and which ones are the fixed the boundary 
                            % conditions. Points in the grid with  
                            % fpts=1 are switched back to the boundary
                            % condition. 0 means free to vary throughout
                            % the averaging process.
                            

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                            

%Section II: Defining fixed boundary conditions. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Defines voltage on the outside edges
    V_init(:,1)=0;  
    fpts(:,1)=1;
    V_init(1,:)=0;  
    fpts(1,:)=1;
    V_init(:,nx)=0; 
    fpts(:,nx)=1;
    V_init(ny,:)=0; 
    fpts(ny,:)=1;
    
    % Defines voltage on negative plate of capacitor to be a boundary cond.
    cap_negx=find((gridx >= d/2) & (gridx <= d/2+.25)); 
    cap_negy=find((gridy >= -5.0) & (gridy <= 5.0));  
    for V_Bndry_Conx=cap_negx
        for V_Bndry_Cony=cap_negy
            V_init(V_Bndry_Cony,V_Bndry_Conx)=-10;
            fpts(V_Bndry_Cony,V_Bndry_Conx)=1;
        end
    end
    
    % Defines voltage on positive plate of capacitor to be a boundary cond.
    cap_posx=find((gridx >= -d/2-.25) & (gridx <= -d/2));  
    cap_posy=find((gridy >= -5.0) & (gridy <= 5.0));  
    for V_Bndry_Conx=cap_posx
        for V_Bndry_Cony=cap_posy
            V_init(V_Bndry_Cony,V_Bndry_Conx)=10;
            fpts(V_Bndry_Cony,V_Bndry_Conx)=1;
        end
    end
    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%Section III: Averaging to get the real potential on the grid.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dVmax=1.;  
dV_accept=.01; %the minimum acceptable change before iterations are stopped
Vold=V_init;    

iter=0;      
converged_ctr=0;    
while converged_ctr < 5     
                            
    iter=iter+1; 
    for pos_x=2:(nx-1)     
        for pos_y=2:(ny-1) 
           Vsol(pos_y,pos_x)=0.125*(Vold(pos_y-1,pos_x) + ...
               Vold(pos_y+1,pos_x) + Vold(pos_y,pos_x-1) ...
               + Vold(pos_y,pos_x+1) + Vold(pos_y-1,pos_x-1) ...
               +Vold(pos_y-1,pos_x+1) + Vold(pos_y+1,pos_x-1)...
               +Vold(pos_y+1,pos_x+1));
        end
    end
    
    Vsol=Vsol.*(1-fpts) + V_init.*fpts;  %Reassigns the solution array 
    %so that the boundary conditions return 
                                         
    dV=(Vsol-Vold)./Vsol;   %A measure of the change in the solution array
                            %from the previous iteration
    ivalid=find((dV >=0.0) & (dV <= 1.0)); 
    [dVmax col]=max(max(dV(ivalid))); %finds the maximum value of dv  
    
    if dVmax <= dV_accept
        converged_ctr=converged_ctr+1; %if maximum value is less than the
        %the tolerance, converged control increments. If this gets to five,
        %then the loop stops. Thus we must have five iterations of change
        %less than dv_accept to end the while loop. 
    else
        converged_ctr=0;
    end
    
    %Outputs the iteration and the dvmax value on the command line
    disp(['Iteration ',int2str(iter),'   dVmax is ',num2str(dVmax,5)])
    
    Vold=Vsol; %Sets the current solution to vold for the next iteration. 
    
    %Change showrelaxation above to 1 to see V after every iteration
    if showrelaxation 
        figure(1)
        surf(gridx,gridy,Vsol)
    end
end


%Outputs the iteration and the dvmax value on the command line
    disp(['Iteration ',int2str(iter),'   dVmax is ',num2str(dVmax,5)])


    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%Section IV: Plot the result

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%Displays countour lines and the actual potential
% figure
% contour(gridx,gridy,Vsol)   
% 
figure 
surf(gridx,gridy,Vsol)
title('Potential Inside a 2D Slice of a Capacitor   ',...
    'interpreter','latex','Fontweight','Bold','Fontsize',24)
xlabel('   X position (cm)     ','interpreter','latex','Fontweight','Bold','Fontsize',18)
ylabel('   Y position (cm)   ','interpreter','latex','Fontweight','Bold','Fontsize',18)
zlabel('   Potential (V)  ','interpreter','latex','Fontweight','Bold','Fontsize',18)
set(get(gca,'zLabel'),'Rotation',0.0)
set(gca, 'Fontweight','Bold','Fontsize',15,'Color','w') 

% Figure for 272 Lecture
% figure 
% surf(gridx,gridy,Vsol/10)
% title('Plot of V in dimensionless units   ','interpreter','latex','Fontweight','Bold','Fontsize',24)
% xlabel('   x position (S)     ','interpreter','latex','Fontweight','Bold','Fontsize',24)
% ylabel('   y position (S)   ','interpreter','latex','Fontweight','Bold','Fontsize',24)
% zlabel('   V ($\frac{S \sigma}{2\epsilon_0}$)   ','interpreter','latex','Fontweight','Bold','Fontsize',24)
% set(get(gca,'zLabel'),'Rotation',0.0)
% set(gca, 'Fontweight','Bold','Fontsize',15,'Color','w') 