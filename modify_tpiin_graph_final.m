function [sub_tpiin trading_matrix]= modify_tpiin_graph_final()

%construct the TPIIN network-----------------------

[num1,txt1,raw1] = xlsread('final_tpiin_dataset.xls');
st_time = tic;
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
suspicious_node=[];
weight=[];
start=[];
target=[];
node_final_count
adjacency_matrix = zeros(size(node_final_count,1),size(node_final_count,1));
node_final_count=[];
for i=1:size(antecent_matrix,1)
    
    x = antecent_matrix(i,1);
    
    y = antecent_matrix(i,2);
    
    cx=0;
    cy=0;
    for m=1:size(node_final_count,2)
        
        if strcmpi(x{1,1},node_final_count{1,m})
            
           cx=m;
           
        
           break;
        end
        
    end
    
    
    for m=1:size(node_final_count,2)
        
        
        if strcmpi(y{1,1},node_final_count{1,m})
            
           cy=m;
           
        
           break;
        end
        
    end
    
    if cx~=0 && cy~=0 
        
        if max(target)>=max(start)
      
            DG=sparse([start,max(target)],[target,max(target)],[weight,100]);
        else
            DG=sparse([start,max(start)],[target,max(start)],[weight,100]);
            
        end
     
      [dist,path,pred] = graphshortestpath(DG,cx,cy);

      infi = isinf(dist);
      if infi==0
        suspicious_node = [suspicious_node;[cx;cy]];
        
        for i=2:size(path,2)-1
        
            suspicious_node = [suspicious_node;path(i,1)];
        end
      end
        %suspicious_node = [suspicious_node;cy];
       % adjacency_matrix(cx,cy)=-1;
      % adjacency_matrix(cy,cx)=-1;
    else
        
        
        if cx==0
        
        
            node_final_count=[node_final_count,x];
        
            cx=size(node_final_count,2);
    
    
        end
        
        if cy==0
    
            node_final_count=[node_final_count,y];
    
            cy=size(node_final_count,2);
        end
        
        
        start = [start,cx];
    
        target = [target,cy];
    
        weight=[weight,1];
    
        adjacency_matrix(cx,cy)=1;
        adjacency_matrix(cy,cx)=1;
       
%         if size(C1,1)~=0 && size(C2,1)==0 
%         
%        
%             adjacency_matrix(cx,cy)=1;
%        
%        
%     
%         elseif size(C1,1)==0 && size(C2,1)~=0 
%         
%        
%             adjacency_matrix(cx,cy)=1;
%        
%        
%     
%         elseif size(C1,1)==0 && size(C2,1)==0 
%         
%     
%             adjacency_matrix(cx,cy)=1;
%        
%     
%         end
%         
    end
end
adjacency_matrix

%---------Find cyclic transition in trading matrix---------


for i=1:size(trading_matrix,1)
    
    x = trading_matrix(i,1);
    
    y = trading_matrix(i,2);
    
     cx=0;
    cy=0;
    for m=1:size(node_final_count,2)
        
        if strcmpi(x{1,1},node_final_count{1,m})
            
           cx=m;
           
        
           break;
        end
        
    end
    
    
    for m=1:size(node_final_count,2)
        
        
        if strcmpi(y{1,1},node_final_count{1,m})
            
           cy=m;
           
        
           break;
        end
        
    end
    
    if cx~=0 && cy~=0 
        
        if max(target)>=max(start)
      
            DG=sparse([start,max(target)],[target,max(target)],[weight,100]);
        else
            DG=sparse([start,max(start)],[target,max(start)],[weight,100]);
            
        end
      i
      size(DG)
      [dist,path,pred] = graphshortestpath(DG,cx,cy);

      infi = isinf(dist);
      if infi==0
        suspicious_node = [suspicious_node;[cx;cy]];
         for i=2:size(path,2)-1
        
            suspicious_node = [suspicious_node;path(i,1)];
        end
      end
        %suspicious_node = [suspicious_node;cy];
       % adjacency_matrix(cx,cy)=-1;
      % adjacency_matrix(cy,cx)=-1;
    else
        
        
        if cx==0
        
        
            node_final_count=[node_final_count,x];
        
            cx=size(node_final_count,2);
    
    
        end
        
        if cy==0
    
            node_final_count=[node_final_count,y];
    
            cy=size(node_final_count,2);
        end
        
        
        start = [start,cx];
    
        target = [target,cy];
    
        weight=[weight,1];
    
      
        adjacency_matrix(cx,cy)=1;
        adjacency_matrix(cy,cx)=1; 
%         if size(C1,1)~=0 && size(C2,1)==0 
%         
%        
%             adjacency_matrix(cx,cy)=1;
%        
%        
%     
%         elseif size(C1,1)==0 && size(C2,1)~=0 
%         
%        
%             adjacency_matrix(cx,cy)=1;
%        
%        
%     
%         elseif size(C1,1)==0 && size(C2,1)==0 
%         
%     
%             adjacency_matrix(cx,cy)=1;
%        
%     
%         end
%         
    end
end
final_time=toc(st_time);


adjacency_matrix
disp('Execution time');
final_time
% Find Suspicious company and user responsible for cyclic path in tree --------------------

disp('Suspicious Tax Evasion');
suspicious_node=unique(suspicious_node)

for i=1:size(suspicious_node,1)
R_prediction(i,1) = node_final_count(1,suspicious_node(i,1));
end
[num1,txt1,raw1] = xlsread('compare_dataset.xls');
work_predict=zeros(size(num1,1),1);

for i=1:size(suspicious_node,1)

    for j=1:size(num1,1)
    
    
        if strcmpi( R_prediction(i,1),txt1{j,1})
    
            work_predict(j,1)=1;
        end
    end
end

TP =0;
FN =0;
FP =0;
TN=0;
for i=1:size(work_predict,1)
    chk=0;
    for j=1:size(work_predict,2)

if work_predict(i,j) ==0 && num1(i,j) ==0
    
           TP = TP +1;
        
elseif work_predict(i,j) >0 && num1(i,j) >0
       
        TN = TN +1;
       
elseif work_predict(i,j) >0 && num1(i,j) ==0

            FP = FP +1;
else
     FN = FN +1;
    
end
    end
end

disp('True Positive');

TP
disp('True Negative');

TN
disp('False Negative');

FN

disp('False Positive');

FP

disp('Presision Value');

p=TP/(TP+FP);
disp(p);

disp('Recall Value');

R=TP/(TP+FN);
disp(R);

disp('F-Measure Value');

F=(2*p*R)/(p+R);
disp(F);

end

