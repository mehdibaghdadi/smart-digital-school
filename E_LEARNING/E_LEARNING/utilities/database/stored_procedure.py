
def call_stored_procedure(con_session,function_name, params):
       connection = con_session.connection().engine.raw_connection()
       try:
            cursor = connection.cursor()
            cursor.callproc(function_name, params)
            results = cursor.fetchall()
            # Get the column names for the results
            indices = [item[0] for item in cursor.description]
            # Create a list of mapped column names to results
            results_list = [dict(zip(indices, result)) for result in results]
            cursor.close()
            connection.commit()
            return results_list
       except Exception as error:
            raise error
       finally:
            connection.close()
