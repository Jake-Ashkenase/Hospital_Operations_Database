"""
Jake Ashkenase
Samuel Platzman
"""


import pymysql
import pandas as pd



try:
    # connect to the database
    cnx = pymysql.connect(host='localhost',
                          user=input("enter username: "),
                          password=input("enter password: "),
                          db='operations',
                          charset='utf8mb4',
                          cursorclass=pymysql.cursors.DictCursor)
    print()
    print("You have connected to the Database!")
    print()

# if credentials are not correct the user must restart
except pymysql.err.OperationalError:
    print("These credentials are not correct")
    exit()


# guidelines on the actions a user can take
print()
print("Welcome to the Hospital maintenance system. Here are the actions you can perform")
print("READ : if you want to read some information from the database")
print("CLEAN ROOM : if you want to update that a room has been cleaned")
print("CLEAN SUIT : if you want to update that a suit has been cleaned")
print("COUNT : if you want to count some of the inventory")
print("REMOVE : if you want to remove PPE from the database")
print("INSERT : if you want to add PPE to the database")
print("VIEW : if you want to view procedues and their specific type")
print()

try:

    # this keeps a loop going so users can do as many actions as they want in the database
    # also asking what task they would like to complete
    continued = 0
    while continued == 0:
        decision = input("What would you like to do:")

        # lets user know if their initial input is incorrect
        if decision not in ["READ", "CLEAN ROOM", "CLEAN SUIT", "COUNT", "REMOVE", "INSERT", "VIEW"]:
            print("That is not a viable option")


        # reading tables ---------------------------------------------------------------------------------------------
        if decision == "READ":

            # options to choose from
            tables = ["box_of_gloves", "box_of_masks", "check_in", "equipment", "equipment_procedure",
                      "medical_condition", "medical_procedure", "nurse", "patient", "patient_condition", "ppe",
                      "ppe_procedure", "procedure_nurses", "room", "staff", "suit", "surgeon"]
            print("Which table would you like to see? ")
            print()
            print("Your options are:", tables)
            print()

            read_correct = 0
            while read_correct == 0:
                read_param = input("Which would you like to read:")

                # makes sure table is a viable option
                if read_param in tables:
                    # puts table in a dataframe
                    c8 = cnx.cursor()
                    stmt_select = "SELECT * FROM operations." + read_param
                    c8.execute(stmt_select)
                    rows = c8.fetchall()
                    df = pd.DataFrame.from_records(rows)
                    print(df)
                    c8.close()
                    read_correct = 1
                else:
                    # tells user the input was wrong
                    print()
                    print("That is not a valid table")
                    print()




        # cleaning a room ---------------------------------------------------------------------------------------------
        elif decision == "CLEAN ROOM":

            valid_room = 0
            while valid_room == 0:
                room_param = input("what room would you like to declare as sanitized:")
                c1 = cnx.cursor()

                stmt_select = "SELECT room_id FROM operations.room"
                c1.execute(stmt_select)

                rows = c1.fetchall()

                list_of_options = []
                for row in rows:
                    list_of_options.append(row["room_id"])

                # checks to make sure the room_id is valid and will ask for another ID if it is not
                if int(room_param) in list_of_options:
                    # using procedure to update a room to clean
                    c1.callproc("clean_rooms", (room_param,) )
                    cnx.commit()
                    c1.close()
                    valid_room = 1
                    print()
                    print("That room has been marked as cleaned. Thank you!")
                    print()
                else:
                    # telling a user their input is wrong
                    print()
                    print("That room_id is not valid please try again")
                    print()



        # cleaning a suit ---------------------------------------------------------------------------------------------
        elif decision == "CLEAN SUIT":

            valid_suit = 0
            while valid_suit == 0:
                suit_param = input("what is the id of the suit would you like to declare as sanitized:")
                c2 = cnx.cursor()

                stmt_select = "SELECT PPE_id FROM operations.suit"
                c2.execute(stmt_select)
                rows = c2.fetchall()

                list_of_options = []
                for row in rows:
                    list_of_options.append(row["PPE_id"])

                # checks to see that the input is correct
                if int(suit_param) in list_of_options:
                    # calls procedure to update a suit to clean
                    c2.callproc("clean_suit", (suit_param,))
                    cnx.commit()
                    c2.close()
                    valid_suit = 1
                    print()
                    print("That suit has been marked as sanitised. Thank you!")
                    print()
                else:
                    # tells the user their input is wrong
                    print()
                    print("That PPE_id is not valid please try again")
                    print()


        # counting PPE ---------------------------------------------------------------------------------------------
        elif decision == "COUNT":


            # asks which PPE they want to use
            print("your options are:    M (masks)  |  G (gloves)  | S (suits) ")
            count_param = input("what PPE item do you want a count of?")
            c3 = cnx.cursor()

            # counts masks
            if count_param == "M":
                stmt_select = "SELECT count(PPE_id) FROM operations.box_of_masks"

            #counts gloves
            elif count_param == "G":
                stmt_select = "SELECT count(PPE_id) FROM operations.box_of_gloves"

            # counts suits
            elif count_param == "S":
                stmt_select = "SELECT count(PPE_id) FROM operations.suit"

            # pulls out the count
            c3.execute(stmt_select)
            rows = c3.fetchall()
            for row in rows:
                value = row["count(PPE_id)"]
            c3.close()
            print()
            print("The count of your selected PPE item is:", str(value))
            print()


        # removing PPE ---------------------------------------------------------------------------------------------
        elif decision == "REMOVE":


            valid_delete = 0
            while valid_delete == 0:
                # asks which type of PPE they want to remove
                print("your options are:    M (masks)  |  G (gloves)  | S (suits) ")
                insert_param = input("what type of PPE would you like to remove:")
                c5 = cnx.cursor()

                # removing gloves
                if insert_param == "G":
                    PPE = input("What is the ID of the gloves you want to remove:")

                    stmt_select = "SELECT PPE_id FROM operations.box_of_gloves"
                    c5.execute(stmt_select)
                    rows = c5.fetchall()
                    list_of_options = []
                    for row in rows:
                        list_of_options.append(row["PPE_id"])

                    # makes sure there is a valid PPE_id, if so calls the procedure to remove
                    if int(PPE) in list_of_options:
                        c5.callproc("delete_glove", (PPE,))
                        cnx.commit()
                        c5.close()
                        print()
                        print("Your PPE has been deleted")
                        print()
                        valid_delete = 1
                    else:
                        print()
                        print("The ID you entered does not exist")
                        print()

                # removing masks
                elif insert_param == "M":
                    PPE = input("What is the ID of the masks you want to remove:")

                    stmt_select = "SELECT PPE_id FROM operations.box_of_masks"
                    c5.execute(stmt_select)
                    rows = c5.fetchall()
                    list_of_options = []
                    for row in rows:
                        list_of_options.append(row["PPE_id"])

                    # makes sure there is a valid PPE_id, if so calls the procedure to remove
                    if int(PPE) in list_of_options:
                        c5.callproc("delete_mask", (PPE,))
                        cnx.commit()
                        c5.close()
                        print()
                        print("Your PPE has been deleted")
                        print()
                        valid_delete = 1
                    else:
                        print()
                        print("The ID you entered does not exist")
                        print()

                # removing suits
                elif insert_param == "S":
                    PPE = input("What is the ID of the suit you want to remove:")

                    stmt_select = "SELECT PPE_id FROM operations.suit"
                    c5.execute(stmt_select)
                    rows = c5.fetchall()
                    list_of_options = []
                    for row in rows:
                        list_of_options.append(row["PPE_id"])

                    # makes sure there is a valid PPE_id, if so calls the procedure to remove
                    if int(PPE) in list_of_options:
                        c5.callproc("delete_suit", (PPE,))
                        cnx.commit()
                        c5.close()
                        print()
                        print("Your PPE has been deleted")
                        print()
                        valid_delete = 1
                    else:
                        print()
                        print("The ID you entered does not exist")
                        print()

                # if the PPE input is incorrect, prompts for another one
                else:
                    print("Please enter a valid type of PPE")

        # inserting PPE --------------------------------------------------------------------------------------------
        elif decision == "INSERT":

            valid_insert = 0
            while valid_insert == 0:
                # asking which type of PPE the user wants to input
                print("your options are:    M (masks)  |  G (gloves)  | S (suits) ")
                insert_param = input("what type of PPE would you like to insert:")
                c4 = cnx.cursor()

                # inserting gloves
                if insert_param == "G":
                    brand = input("Brand:")
                    count = input("Count:")

                    c4.callproc("insert_gloves", (brand, count))
                    cnx.commit()
                    c4.close()
                    print()
                    print("Your PPE has been added")
                    print()
                    valid_insert = 1

                # inserting masks
                elif insert_param == "M":
                    brand = input("Brand:")
                    type = input("Type:")
                    count = input("Count:")

                    c4.callproc("insert_masks", (brand, type, count))
                    cnx.commit()
                    c4.close()
                    print()
                    print("Your PPE has been added")
                    print()
                    valid_insert = 1

                # inserting suits
                elif insert_param == "S":
                    size = input("Size:")
                    type = input("Type:")
                    washed = input("Is it washed? (enter 0 if not washed, 1 if washed) :")

                    c4.callproc("insert_suit", (size, type, washed))
                    cnx.commit()
                    c4.close()
                    print()
                    print("Your PPE has been added")
                    print()
                    valid_insert = 1

                # telling the user their input was not correct
                else:
                    print("Please enter a valid type of PPE")



        # viewing a procedure ----------------------------------------------------------------------------------------
        elif decision == "VIEW":

            valid_procedure = 0
            while valid_procedure == 0:
                procedure_param = input("what procedure would you like to view:")

                c6 = cnx.cursor()
                stmt_select = "SELECT procedure_id FROM operations.medical_procedure"
                c6.execute(stmt_select)
                rows = c6.fetchall()
                c6.close()
                list_of_options = []
                for row in rows:
                    list_of_options.append(row["procedure_id"])

                # making sure the procedure given is valid
                if int(procedure_param) in list_of_options:
                    c9 = cnx.cursor()
                    c9.callproc("view_procedure", (procedure_param,))
                    result = c9.fetchall()
                    df = pd.DataFrame.from_records(result)
                    print("The procedure type was",
                          df["type"][0],
                          "and the the PPE used had the id's:",
                          list(df["ppe_id"]))
                    print()
                    c9.close()
                    valid_procedure = 1


        # does the user want to do something else? --------------------------------------------------------------------
        question_continue = input("Would you like to do something else? if yes enter Y (no spaces), "
                                  "if not enter anything else: ")
        print()

        # asks the user if they would like to do something else
        if question_continue == "Y":
            pass
        else:
            continued = 1
            print()
            print("Thank you for using our database!")

except pymysql.Error as e:
    print("This input is not supported")
    print("The database must be restarted to try again")

finally:
    cnx.close()


