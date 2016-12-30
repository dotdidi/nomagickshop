# Products
Product.create!(title: "Titan Fall 2",
                desc: "Call down your Titan and get ready for an exciting first-person combat 
                       experience in Titanfall 2®! The sequel introduces a new single player campaign, 
                       where you can delve into the unique bond between Pilot and Titan. Or blast your way 
                       through an even more innovative and intense multiplayer experience - featuring 6 new Titans, 
                       deadly new Pilot abilities, expanded customization, new maps, modes, and much more.",
                img_url: "https://key4co.in/wp-content/uploads/2016/10/Titanfall-2-Cover.jpg",
                price: "31.90"
               )

Product.create!(title: "Final Fantasy XV",
                desc: "Enroute to wed his fiancée Luna on a road trip with his best friends, Prince Noctis is advised by 
                       news reports that his homeland has been invaded and taken over under the false pretense of a peace treaty – 
                       and that he, his loved one and his father King Regis, have been slain at the hands of the enemy.
                       To gather the strength needed to uncover the truth and reclaim his homeland, Noctis and his loyal companions
                       must overcome a series of challenges in a spectacular open world - that is filled with larger-than-life creatures,
                       amazing wonders, diverse cultures and treacherous foes.",
                img_url: "https://images-na.ssl-images-amazon.com/images/I/81WyEyShisL._AC_SL1500_.jpg",
                price: "39.00"
               )
Product.create!(title: "The Last Guardian",
                desc: "In a strange and mystical land, a young boy discovers a mysterious creature with which he forms a deep unbreakable bond.
                       The unlikely pair must rely on each other to journey through towering treacherous ruins filled with unknown dangers.",
                img_url: "https://images-na.ssl-images-amazon.com/images/I/91syJhZlWEL._AC_SL1500_.jpg",
                price: "58.79"
               )

# Users
User.create!(username: "didi",
             email: "didi@nomagickshop.com",
             password: "123123",
             password_confirmation: "123123",
             admin: true
            )
