import 'package:cached_network_image/cached_network_image.dart';
import 'package:div_news/helper/data.dart';
import 'package:div_news/helper/internect_connection.dart';
import 'package:div_news/helper/news.dart';
import 'package:div_news/model/article_model.dart';
import 'package:div_news/model/category_model.dart';
import 'package:div_news/views/articile_view.dart';
import 'package:div_news/views/category_news.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  List<CategoryModel> categories = [];
  List<ArticleModel> articles= [];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }
  getNews() async{

    bool internet = await internetConnection();

    if(internet){
      News newsClass = News();
      await newsClass.getNews();
      articles = newsClass.news;

      setState(() {
        _loading = false;
      });
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('No internet Connection Available'),
        duration: const Duration(seconds: 500),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            getNews();
          },
        ),
      ));
    }

  }


  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    getNews();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
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
        elevation: 0,
        centerTitle: true,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16),
                height: 70,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                  return CategoryTile(imageUrl: categories[index].imageUrl,categoryName: categories[index].categoryName);
                }),
              ),
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  CategoryTile({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(category: categoryName.toLowerCase(),)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26
                ),
                child:
                Text(
                  categoryName,
                  style: GoogleFonts.roboto(
                      color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                )
            )
          ],
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
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(6),
            //   child: Image.network(imageUrl),
            // ),

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
