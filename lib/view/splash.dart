import 'package:flutter/material.dart';
import 'package:petadoption/core/constants/asset_images.dart';
import 'package:petadoption/core/route/routes.dart';

import '../utils/text_style_helper.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Image.asset(AssetImages.paw,width: size.width * 0.6,),
            Text('Choose Pets',style: appTextStyle(fontSize: 42,fontWeight: FontWeight.bold),),
            Text('Find your perfect pet companion',style: appTextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
            Expanded(child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, Routes.homePage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                      child: Row(
                        children: [

                          const CircleAvatar(radius: 24,
                            backgroundColor: Colors.black,
                           child: Image(image: AssetImage(AssetImages.paw),color: Colors.white,width: 24,),
                          ),
                          const SizedBox(width: 8,),
                          Text('Get Started',style: appTextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
