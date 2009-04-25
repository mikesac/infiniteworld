package org.infinite.engines.account;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.util.List;

import org.infinite.db.Manager;
import org.infinite.db.dao.TomcatUsers;
import org.junit.Test;

public class AccountEngineTest {

	String USER = "testUser";
	String PASS = "testPass";
	String EMAIL = "test@test.org";
	String ROLE = "player";
	
	@SuppressWarnings("unchecked")
	@Test
	public void testRegisterNewUserStringStringStringStringStringBoolean() {
		
		
		try {
			AccountEngine.registerNewUser(USER, PASS, EMAIL, "", "",false);
			
			List<TomcatUsers> l = Manager.listByQuery("select u from TomcatUsers u where u.user='"+USER+"'");
			
			assertNotNull(l);
			assertEquals(l.size(), 1);
			
			TomcatUsers t = l.get(0);
			assertNotNull(t);
			
			assertEquals(t.getUser(), USER);
			assertEquals(t.getPassword(), PASS);
			assertEquals(t.getEmail(), EMAIL);
			assertNotNull(t.getTomcatRoles());
			assertEquals(t.getTomcatRoles().getUser(), USER);
			assertEquals(t.getTomcatRoles().getRole(), ROLE);
			
			Manager.delete(t);
			
		} catch (Exception e) {
			fail( e.getMessage() );
		}
		
		
	}

}
