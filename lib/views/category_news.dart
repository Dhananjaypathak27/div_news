import 'package:div_news/helper/news.dart';
import 'package:div_news/model/article_model.dart';
import 'package:div_news/views/articile_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryNews extends StatefulWidget {

  final String category;


  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategoryNews();
  }
  getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Div',style: GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.bold),),
            Text('News',style: GoogleFonts.roboto(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
          ],
        ),
        actions: [

          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body:_loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child:  SingleChildScrollView(
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context,index){
                  print('here is url ${articles[index].url}');
                  return BlogTile(imageUrl: articles[index].urlToImage, title: articles[index].title, decs: articles[index].description,url: articles[index].url,);
                }),
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl,title,decs,url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.decs,@required this.url});

  @override
  Widget build(BuildContext context) {
    print('my url $url');
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(blogUrl: url,)
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: ExtendedImage.network(
                imageUrl,
                width: MediaQuery.of(context).size.width/0.2,
                height: 200,



                fit: BoxFit.cover,
                cache: false,
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(6),
                //cancelToken: cancellationToken,
              ),
            ),

            SizedBox(height: 7,),
            Text(title,style: GoogleFonts.roboto(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.w800),),
            SizedBox(height: 7,),
            Text(decs,style: GoogleFonts.roboto(fontSize: 14,color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}