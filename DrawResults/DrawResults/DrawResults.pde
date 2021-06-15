/**
 * Draw Result Final Version
 * Last Updated on 2021.06.06
 * Designed by LCF
 */
int r=450;//const int radius of circle

String[] linesE;//primary data
String[] linesV;//primary data
/********************************************************************/
class Edge
{
  int V1,V2;
  int count;
  Edge()
  {
    V1=0;
    V2=0;
    count=0;
  }
}
Edge edge[];

class FinalEdgeSet
{
  Edge edg[];
  int recordedNum;
  int size;
  FinalEdgeSet(int n)
  {
    size=n;
    edg=new Edge[n];
    for(int i=0;i<n;i++)
    {
      edg[i]=new Edge();
    }
  }
  
  boolean IsRecorded(Edge eg)
  {
    int id1=eg.V1;
    int id2=eg.V2;
    for(int i=0;i<recordedNum;i++)
    {
      if(edg[i].V1==id1&&edg[i].V2==id2 || edg[i].V2==id1&&edg[i].V1==id2)
      {
        return true;
      }
    }
    return false;
  }
  void AddRecord(Edge eg)
  {
    int id1=eg.V1;
    int id2=eg.V2;
    int ct=eg.count;
    if(recordedNum<size)
    {
      edg[recordedNum].V1=id1;
      edg[recordedNum].V2=id2;
      edg[recordedNum].count=ct;
      recordedNum++;
    }
  }
  void UpdateExistingRecord(Edge eg)
  {
    int id1=eg.V1;
    int id2=eg.V2;
    int ct=eg.count;
    for(int i=0;i<recordedNum;i++)
    {
      if(edg[i].V1==id1&&edg[i].V2==id2 || edg[i].V2==id1&&edg[i].V1==id2)
      {
        edg[i].count+=ct;
      }
    }
  }
}
FinalEdgeSet finalEdge;
/********************************************************************/
class Vertex
{
  int ENSP;
  String GeneName;
  int betw;
  float x,y;
  float alpha;
  Vertex()
  {
    ENSP=0;
    betw=0;
    x=0;
    y=0;
    alpha=0;
  }
}
Vertex vex[];

/********************************************************************/
class HashCell
{
  int Key;
  int ptr;
  HashCell()
  {
    Key=0;
    ptr=-1;
  }
}
class HashTable
{
  int n,d;
  HashCell c[];
  
  /************************************************/
  HashTable(int N)
  {
    n=N;
    c = new HashCell[n];
    d=2;
    for(int j=2;j<n;j++)//generate largest prime number as hash function
    {
      boolean flg=false;
      for(int i=2; i<sqrt(j)+2&&flg==false;i++)
      {
        if(j%i==0)//dividable, jump out of the loop
        {
          flg=true;
          break;
        }
      }
      if(flg==false)
      {
        d=j;
      }
    }//end for
    
    for(int i=0;i<n;i++)
    {
      c[i]=new HashCell();
    }
    
    
    
  }//end InitHash
  /************************************************/
  int GetIdx(int k)//get the index of vertex via ENSP
  {
    int idx= k%d;
    for(int i=0;i<n;i++,idx=((k)%d+i)%n)
    {
      if(c[idx].Key==k)//search success
      {
         return c[idx].ptr; 
      }
    }
    return 0;
  }
  /************************************************/
  boolean Write(Vertex v,int k)
  {
    int idx=v.ENSP%d;
    if(c[idx].ptr==-1)//empty
    {
      c[idx].ptr=k;
      c[idx].Key=v.ENSP;
      return true;
    }
    else
    {
      int hkey=v.ENSP%d;
      for(int i=0 ; i<n; i++)
      {
        idx=(hkey+i)%n;
        if(c[idx].ptr==-1)//search success,found empty cell
        {
          c[idx].ptr=k;
          c[idx].Key=v.ENSP;
          return true;
        }
        //print("k:");println(k);
        //print("idx:");println(idx);
      }
    }
    return false;
  }
  
  /************************************************/
}

HashTable H;

/********************************************************************/
int total=1;//total of results
int vertexTotal=1;////////

float theta=0;



/********************************************************************/
void colorMap(int val)
{
  color c;
  if(val<1000)
  {
    c=color(198,198,198);
  }
  else if(val>1000&&val<=2000)
  {
    c=color(254,204,3);
  }
  else if(val>2000&&val<=4000)
  {
    c=color(30,251,0);
  }
  else if(val>4000&&val<=8000)
  {
    c=color(42,254,237);
  }
  else if(val>8000&&val<=12000)
  {
    c=color(0,90,255);
  }
  else if(val>12000&&val<=20000)
  {
    c=color(250,0,0);
  }
  else
  {
    c=color(0,0,0);
  }
  fill(c);
  stroke(c);
}
/********************************************************************/
void labelColor()
{
  float xPos=84;
  float xPos2=xPos+(58.8);
  float yPos=51;
  float yPos2=yPos+(-14.0);
  float delta=32.1;
  float w=19;
  
    fill(0);
    textSize(15);
    textAlign(CENTER);
    
    fill(0);
    text("<1000",xPos,yPos);
    colorMap(900);
    rect(xPos2,yPos2,w,w);

    fill(0);
    text("1000-2000",xPos,yPos+1*delta);
    colorMap(1200);
    rect(xPos2,yPos2+1*delta,w,w);
    
    fill(0);
    text("2000-4000",xPos,yPos+2*delta);
    colorMap(3000);
    rect(xPos2,yPos2+2*delta,w,w);
    
    fill(0);
    text("4000-8000",xPos,yPos+3*delta);
    colorMap(5000);
    rect(xPos2,yPos2+3*delta,w,w);
    
    fill(0);
    text("8000-12000",xPos,yPos+4*delta);
    colorMap(10000);
    rect(xPos2,yPos2+4*delta,w,w);
    
    
    fill(0);
    text("12000-20000",xPos,yPos+5*delta);
    colorMap(15000);
    rect(xPos2,yPos2+5*delta,w,w);
    
    fill(0);
    text(">=20000",xPos,yPos+6*delta);
    colorMap(21000);
    rect(xPos2,yPos2+6*delta,w,w);
    
    /*
    fill(0);
    text("For edge count, multiply by 2 in order to show greater contrast.",xPos,yPos+7*delta);//scrip
    */
}
/********************************************************************/
void drawVertex(Vertex v)
{
  int VRadius=15;
  int outerDeltaRadius=40;
  smooth();
  
  strokeWeight(1.0);
  stroke(215);//thin and light indication line
  line(v.x,v.y,v.x+cos(v.alpha)*outerDeltaRadius+(0.0),v.y+sin(v.alpha)*outerDeltaRadius+(0.0));
  
  //noStroke();
  strokeWeight(1.0);
  //fill(207);//circle color
  colorMap(v.betw);//map to color chart
  ellipse(v.x,v.y,VRadius,VRadius);
  textSize(12.9);
  fill(61);//text color
  textAlign(CENTER);
  text(v.GeneName,v.x+cos(v.alpha)*outerDeltaRadius+(0.0),v.y+sin(v.alpha)*outerDeltaRadius+(0.0));
}

/********************************************************************/

void drawEdge(Edge e)
{
  float para=0.0;///////////////////////
  float offset=random(-para,para);
  smooth();
  //stroke(map(e.count,1000,10000,255,0));//map to greyscale
  //stroke(0);
  
  colorMap(e.count);//map to color chart
  strokeWeight(1.0);
  line(vex[H.GetIdx(e.V1)].x+offset,vex[H.GetIdx(e.V1)].y+offset,vex[H.GetIdx(e.V2)].x+offset,vex[H.GetIdx(e.V2)].y+offset);//drift offset
}





/********************************************************************/
void setup() {
  size(1200, 1000);
  background(255);
  stroke(255);
  frameRate(12);
  linesE = loadStrings("resultsE.txt");
  linesV = loadStrings("resultsV.txt");
  
  /************************************************/
  total= linesE.length;          //edge
  edge = new Edge[total];
  finalEdge=new FinalEdgeSet(total);
  //println(edge.length);
  //println(total);
  for (int i=0;i < total;i++) //Read all the edge
  {
    String[] pieces = split(linesE[i], '\t');
    edge[i]=new Edge();
    if (pieces.length == 3) 
    {
       edge[i].V1 = int(pieces[0]);///
       edge[i].V2 = int(pieces[1]);
       edge[i].count = int(pieces[2]);
    }
  }//end for(int i=0;i < total;i++) //Read all the edge
 
 
  /************************************************/
  vertexTotal = linesV.length;  //vertex
  theta=(2*PI)/vertexTotal;
  vex = new Vertex[vertexTotal];
  for (int i=0;i < vertexTotal;i++) //Read all the Vertices
  {
    String[] piecesV = split(linesV[i], '\t');
    vex[i]=new Vertex();
    if (piecesV.length == 3) 
    {
       vex[i].ENSP = int(piecesV[0]);///
       vex[i].GeneName = piecesV[1];
       vex[i].betw = int(piecesV[2]);
    }
  }//end for(int i=0;i < total;i++) //Read all the Vertices
  
  for(int i=0;i<vertexTotal;i++)
  {
    vex[i].x=r*cos(theta*(i))+width/2+(50.0);
    vex[i].y=r*sin(theta*(i))+height/2;
    vex[i].alpha=theta*(i);
  }

  /************************************************/
  H= new HashTable(vertexTotal);
  for(int i=0;i<vertexTotal;i++)
  {
    print("Hash Write:");
    print(i);
    print("\t");
    println(H.Write(vex[i],i));
  }
/***///test print
  println("H.n: "+H.n);
  println("H.d: "+H.d);
  println("H.GetIdx(417281): "+H.GetIdx(417281));
  println("vex[H.GetIdx(417281)].ENSP:"+vex[H.GetIdx(417281)].ENSP);

  for(int i=0;i<H.n;i++)
  {
    print("Hash Read:");
    print(H.c[i].Key);
    print("\t");
    println(H.c[i].ptr);
  }
  
  //clear repetition
  for(int i=0;i<total;i++)
  {
    if(!finalEdge.IsRecorded(edge[i]))//is not recorded
    {
      finalEdge.AddRecord(edge[i]);
    }
    else
    {
      finalEdge.UpdateExistingRecord(edge[i]);
    }
  }
  
  println("Edge:");
  for(int i=0;i<finalEdge.recordedNum;i++)
  {
    print("V1: "+finalEdge.edg[i].V1);  print("\t    ");  print("V2: "+finalEdge.edg[i].V2);  print("\t    ");  println("count: "+finalEdge.edg[i].count);
    
  }
  

}//end setup()


/********************************************************************/
void draw() 
{
  background(255);
  labelColor();

  /*for(int i=0;i<total;i++)
  {
    drawEdge(edge[i]);
  }
  */
  for(int i=0;i<finalEdge.recordedNum;i++)
  {
    //if(finalEdge.edg[i].count>=8000)////////////////delete this line when necessary
    drawEdge(finalEdge.edg[i]);
  }
  for(int i=0;i<vertexTotal;i++)
  {
    //if(vex[i].betw>=8000)////////////////////delete this line when necessary
    drawVertex(vex[i]);
  }
  

}