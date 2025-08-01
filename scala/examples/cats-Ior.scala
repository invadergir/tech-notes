  "Ior usage" >> {
    import cats.data.Ior
    import cats.implicits._
    {
      val i: Option[Ior[Int, Int]] = Ior.fromOptions( 1.some, 2.some )
      i.isDefined should_== true
      i.get.left should_== 1.some
      i.get.right should_== 2.some
    }
    {
      val i: Option[Ior[Int, Nothing]] = Ior.fromOptions( 1.some, None )
      i.isDefined should_== true
      i.get.left should_== 1.some
      i.get.right should_== None
    }
    {
      val i: Option[Ior[Int, Int]] = Ior.fromOptions( 1.some, None )
      i.isDefined should_== true
      i.get.left should_== 1.some
      i.get.right should_== None
    }
    {
      val i: Option[Ior[Int, Int]] = Ior.fromOptions( None, 2.some )
      i.isDefined should_== true
      i.get.left should_== None
      i.get.right should_== 2.some
    }
    {
      val i: Option[Ior[Int, Int]] = Ior.fromOptions( None, None )
      i.isDefined should_== false
    }
  }
