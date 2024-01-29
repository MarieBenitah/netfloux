import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfloux/models/movie.dart';

class MovieInfo extends StatelessWidget {
  final Movie movie;
  const MovieInfo({Key? key, required this.movie}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      SizedBox(height: 10,
              ),
              Text(
                movie.name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5,),
              Text('Genres : ${movie.reformateGenres()}',
              style: GoogleFonts.poppins(
                color:  Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),
              ),
              SizedBox(height: 10,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 5
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),

                    ),
                    child: Text(
                      movie.releaseDate!.substring(0, 4),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text( 'Recommandé à ${(movie.vote! * 10).toInt()}%',
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),

                  )
                ],
              )
      ]
    );
  }
}
