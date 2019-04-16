function [sub_tpiin trading_matrix]= modify_tpiin_graph()

%construct the TPIIN network-----------------------

[num1,txt1,raw1] = xlsread('final_tpiin_dataset.xls');

% create antecent matrix 
antecent_matrix = {};
count=1;
node_count=1;

for i=1:size(txt1,1)

    if strcmp(txt1{i,4},'blue')
        
        antecent_matrix{count,1}=txt1{i,1};
        antecent_matrix{count,2}=txt1{i,2};
        dfs{node_count,1}=txt1{i,1};
        dfs{node_count+1,1}=txt1{i,2};
        node_count=node_count+2;
         count=count+1;
    end
    
    
end

dfs=unique(dfs);
% create trading matrix 
trading_matrix = {};
count=1;
for i=1:size(txt1,1)

    if strcmp(txt1{i,4},'black')
        
        trading_matrix{count,1}=txt1{i,1};
        trading_matrix{count,2}=txt1{i,2};
        count=count+1;
        
    end
    
    
end

node_count = unique(antecent_matrix(:,1));

node_count = [node_count;unique(antecent_matrix(:,2))];
%node_count
ajacency_node_count = unique(node_count);


%ajacency_node_count
node_count = unique(trading_matrix(:,1));

node_count = [node_count;unique(trading_matrix(:,2))];

ajacency_node = unique(node_count);
temp=[ajacency_node;ajacency_node_count];
node_final_count = unique(temp);

%---------------Insert edge in Tree -------
node_list = [];

node_final_count
adjacency_matrix = zeros(size(node_final_count,1),size(node_final_count,1));
for i=1:size(antecent_matrix,1)
    
    x = antecent_matrix(i,1);
    
    y = antecent_matrix(i,2);
    
    for m=1:size(node_final_count,1)
        
        if strcmpi(x{1,1},node_final_count{m,1})
            
           cx=m;
           
        
           break;
        end
        
    end
    
    
    for m=1:size(node_final_count,1)
        
        
        if strcmpi(y{1,1},node_final_count{m,1})
            
           cy=m;
           
        
           break;
        end
        
    end
    
    [C1 Ia1 Ib1]=intersect(x,node_list);
    
    [C2 Ia2 Ib2]=intersect(y,node_list);
    
    if size(C1,1)==0
        
        node_list=[node_list;x];
    end
    
    
    if size(C2,1)==0
        
        node_list=[node_list;y];
    end
    
    
    if size(C1,1)~=0 && size(C2,1)~=0 
        
      
        
        adjacency_matrix(cx,cy)=-1;
       adjacency_matrix(cy,cx)=-1;
       
    elseif size(C1,1)~=0 && size(C2,1)==0 
        
       adjacency_matrix(cx,cy)=1;
       
       
    elseif size(C1,1)==0 && size(C2,1)~=0 
        
       adjacency_matrix(cy,cx)=1;
       
       
    elseif size(C1,1)==0 && size(C2,1)==0 
        
       adjacency_matrix(cy,cx)=1;
       adjacency_matrix(cx,cy)=1;
       
    end
end

adjacency_matrix

%---------Find cyclic transition in trading matrix---------


for i=1:size(trading_matrix,1)
    
    x = trading_matrix(i,1);
    
    y = trading_matrix(i,2);
    
    for m=1:size(node_final_count,1)
        
        if strcmpi(x{1,1},node_final_count{m,1})
            
           cx=m;
           
        
           break;
        end
        
    end
    
    
    for m=1:size(node_final_count,1)
        
        
        if strcmpi(y{1,1},node_final_count{m,1})
            
           cy=m;
           
        
           break;
        end
        
    end
    
    [C1 Ia1 Ib1]=intersect(x,node_list);
    
    [C2 Ia2 Ib2]=intersect(y,node_list);
    
    if size(C1,1)==0
        
        node_list=[node_list;x];
    end
    
    
    if size(C2,1)==0
        
        node_list=[node_list;y];
    end
    
    
    if size(C1,1)~=0 && size(C2,1)~=0 
        
       adjacency_matrix(cx,cy)=-1;
       adjacency_matrix(cy,cx)=-1;
       
    elseif size(C1,1)~=0 && size(C2,1)==0 
        
       adjacency_matrix(cx,cy)=1;
       
       
    elseif size(C1,1)==0 && size(C2,1)~=0 
        
       adjacency_matrix(cy,cx)=1;
       
       
    elseif size(C1,1)==0 && size(C2,1)==0 
        
       adjacency_matrix(cy,cx)=1;
       adjacency_matrix(cx,cy)=1;
       
    end
end

adjacency_matrix

% Find Suspicious company and user responsible for cyclic path in tree --------------------
S=[];
T=[];
W=[];

Ss=[];
Tt=[];
Ww=[];


for i=1:size(adjacency_matrix,1)
    for j=1:size(adjacency_matrix,2)

        temp=adjacency_matrix(i,j);
        if adjacency_matrix(i,j)~=0
        
            if adjacency_matrix(i,j)~=-1
            
                S=[S,i];
            
                T=[T,j];
            
                W=[W,adjacency_matrix(i,j)];
            else
                
                
                Ss=[Ss,i];
            
                Tt=[Tt,j];
            
                Ww=[Ww,adjacency_matrix(i,j)];
                
            end
        end
    end
end

DG=sparse(S,T,W);
DG
%h = view(biograph(DG,[],'ShowWeights','on'));

for i=1:size(S,1)
   
   
[dist,path,pred] = graphshortestpath(DG,S,T);


end
edge_count=0;
count=1;
L=1;
antecent_matrix_org=antecent_matrix;
while edge_count<size(antecent_matrix,1)-1
    
    temp_mwcs={};
    PA_vertSet = {};
PA_edgeSet = {};
    for k=1:size(dfs,1)
        if size(dfs{k,1},2)>1
       
            temp_mwcs{1,1}=dfs{k,1};
            dfs{k,1}=[];
            break;
        end
    end
    if edge_count>1388
       edge_count 
    end
    if size(temp_mwcs,2)==0
       break; 
    end
    for j=1:size(antecent_matrix,1)
    
        for k=1:size(temp_mwcs,1)
    
            xx=antecent_matrix{j,1};
    
            xy=antecent_matrix{j,2};
            yy=temp_mwcs{k,1};
        if strcmpi(xx,yy) %|| strcmp(txt1{i,3},temp_mwcs{k,1})
        
            temp_mwcs{size(temp_mwcs,1)+1,1} = xy;
            
        
            PA_edgeSet{size(temp_mwcs,1)+1,1}=xx;
            PA_edgeSet{size(temp_mwcs,1)+1,2}=xy;
            antecent_matrix{j,1}=[];
            antecent_matrix{j,2}=[];
            edge_count=edge_count+1;
        elseif strcmpi(xy,yy)
        
            temp_mwcs{size(temp_mwcs,1)+1,1} = xx;
            
        
            PA_edgeSet{size(temp_mwcs,1)+1,1}=xx;
            PA_edgeSet{size(temp_mwcs,1)+1,2}=xy;
                       antecent_matrix{j,1}=[];
            antecent_matrix{j,2}=[];
            edge_count=edge_count+1;
        end
        end
    end
    
    for k=1:size(temp_mwcs,1)
            for j=1:size(dfs,1)
            
                if strcmpi(temp_mwcs{k,1},dfs{j,1})
                    dfs{j,1}=[];
                    break;
                end
            end
    end
    
    sub_tpiin{L,1}=temp_mwcs;
    sub_tpiin{L,2}=PA_edgeSet;
    L=L+1;
end


end

