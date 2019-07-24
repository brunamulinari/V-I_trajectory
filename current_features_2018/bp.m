function bppoints = bp(partA, partB, splot)

% bp -  The bending points:
% This function find the bending points of V-I trajectory. 
% It is our interpretation of the formulation presented in:
% A. L. Wang, B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive load 
% monitoring algorithm based on features of V–I trajectory" Electric Power 
% Systems Research, 2018.
% Função para encontrar os pontos de inflexão de acordo com WANG, 2018.
% 
% IN:
% partA is the part A of V-I trajectory* 
% partB is the part A of V-I trajectory* 
% splot is a struct to plot the features. In this struct has a variable to
% plot (1 - Yes; 0 - No) and the number of load.
%                       splot = struct('load', nload, ...
%                                       'splot', 0);
% *To obtain the parts(A and B) use the function "parts_division"
% 
% OUT:
% bppoints is a vector [a1, a2, b1, b2] where a1 is the bending point
% in part A and a2 the point in part B with the minimum argument. The 
% meaning is the same for b1 and b2
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

% Find the point a1 
LA = size(partA,1)-10;
bpaux1 = zeros(LA,1);
for k=10:LA
    
    m = partA(k,:);
    n = partA(k+1,:);
    o = partA(k+2,:);
    p = partA(k+3,:);
    mn = n-m;
    op = p-o;
    mmn = norm(mn);
    mop = norm(op);
    pe = dot(mn,op);
    bpaux1(k,1)=acosd(abs(pe/(mmn*mop)));   
end
[~, a1] = max(bpaux1);

% Find the point b1
LB = size(partB,1)-10;
bpaux2 = zeros(LB,1);
for k=10:LB
    
    m = partB(k,:);
    n = partB(k+1,:);
    o = partB(k+2,:);
    p = partB(k+3,:);
    mn = n-m;
    op = p-o;
    mmn = norm(mn);
    mop = norm(op);
    pe = dot(mn,op);
    bpaux2(k)=acosd(abs(pe/(mmn*mop)));
    
end
[~, b1] = max(bpaux2);


% Find the point a2 (Point which has the closest voltage a1)
[ind_dif_a] = abs(partB(:,1)-partA(a1,1));
[~,a2] = min(ind_dif_a);

% Find the point b2 (Point which has the closest voltage b1)
[ind_dif_b] = abs(partA(:,1)-partB(b1,1));
[~,b2] = min(ind_dif_b);

% Points
bppoints = [a1, a2, b1, b2];

% Shows the features
if(splot.plot == 1)
       
    figure()    
    plot(partA(:,1), partA(:,2), 'b')
    hold on
    plot(partB(:,1), partB(:,2), 'g')
    hold on 
    plot(partA(a1,1),partA(a1,2),'ro')
    hold on 
    plot(partB(a2,1),partB(a2,2),'*m')
    hold on 
    plot(partB(b1,1),partB(b1,2),'^')
    hold on 
    plot(partA(b2,1),partA(b2,2),'v')
    legend('part A', 'part B', 'a1', 'a2', 'b1', 'b2')   
    title(sprintf('The bending points - Load %d', splot.load))

end

end