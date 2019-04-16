function [sub_tpiin trading_matrix]= sub_tpiin_graph()

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

% create MWCS matrix 

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

