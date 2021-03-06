package com.grain.controller.factoryuser;

import java.security.MessageDigest;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grain.CommonAttributes;
import com.grain.Json;
import com.grain.Principal;
import com.grain.entity.user.Factoryuser;
import com.grain.entity.user.FarmerUser;
import com.grain.service.CaptchaService;
import com.grain.service.user.FactoryuserService;

@Controller
@RequestMapping("factory/common")
public class FactoryCommonController {
	
	@Resource(name = "captchaServiceImpl")
	private CaptchaService captchaService;
	
	@Resource(name = "factoryuserServiceImpl")
	private FactoryuserService factoryusersrv;
	
	@RequestMapping("/main")
	public String mainEntrance(HttpSession session,ModelMap model) {
		Principal p =(Principal) session.getAttribute(CommonAttributes.Principal);
		if (p!=null){
			Factoryuser u = factoryusersrv.findByUsername(p.getUsername());
			if (u==null) return "redirect:/factory/common/login";
			model.addAttribute("userName",u.getUsername());
		} else
			return "redirect:/factory/common/login";
		return "factory/main";
	}
	
	@RequestMapping("/user/editFactoryEntrance")
	public String editExpertEntrance(HttpSession session, Model model) throws Exception{
		Principal p =(Principal) session.getAttribute(CommonAttributes.Principal);
		String username = "";
		if(p != null){
			username = p.getUsername();
		}else{
			throw new Exception("session is losed!");
		}
		
		model.addAttribute("user", factoryusersrv.findByUsername(username));
		return "factory/user/editUserSelf";
	}
	
	@RequestMapping("/user/editFactory")
	@ResponseBody
	public Json editInvestor(Factoryuser factory){
		Json json = new Json();
		factory.setHasaudit(true);
		try {
			factoryusersrv.update(factory);
			json.setSuccess(true);
			json.setMsg("修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("修改失败");
		}
		return json;
		
	}
	
	@RequestMapping("/user/editFactoryPass")
	@ResponseBody
	public Json editFactoryPass(Factoryuser factory,@RequestParam(value="oldpassword") String oldpassword){
		Json json = new Json();
		
		Factoryuser factoryuser = factoryusersrv.findByUsername(factory.getUsername());
		String originalpassword = factoryuser.getPass();
		
		String pass = new String();
		 try {
		        //生成实现指定摘要算法的 MessageDigest 对象。
		        MessageDigest md = MessageDigest.getInstance("MD5");  
		        //使用指定的字节数组更新摘要。
		        md.update(oldpassword.getBytes());
		        //通过执行诸如填充之类的最终操作完成哈希计算。
		        byte b[] = md.digest();
		        //生成具体的md5密码到buf数组
		        int i;
		        StringBuffer buf = new StringBuffer("");
		        for (int offset = 0; offset < b.length; offset++) {
		          i = b[offset];
		          if (i < 0)
		            i += 256;
		          if (i < 16)
		            buf.append("0");
		          buf.append(Integer.toHexString(i));
		        }
		        pass = buf.toString();
//		        System.out.println("32位: " + buf.toString());// 32位的加密
//		        System.out.println("16位: " + buf.toString().substring(8, 24));// 16位的加密，其实就是32位加密后的截取
		     }
		     catch (Exception e) {
		       e.printStackTrace();
		     }

		if(originalpassword.equals(pass)){
			factory.setHasaudit(true);
			try {
				factoryusersrv.update(factory);
				json.setSuccess(true);
				json.setMsg("修改成功");
			} catch (Exception e) {
				e.printStackTrace();
				json.setSuccess(false);
				json.setMsg("修改失败");
			}
		}else{
			json.setSuccess(false);
			json.setMsg("原密码不正确");
		}
		return json;
		
	}
	
	@RequestMapping("/user/editPasswordEntrance")
	public String editPasswordEntrance(HttpSession session, Model model) throws Exception{
		Principal p =(Principal) session.getAttribute(CommonAttributes.Principal);
		String username = "";
		if(p != null){
			username = p.getUsername();
		}else{
			throw new Exception("session is losed!");
		}
		
		model.addAttribute("user", factoryusersrv.findByUsername(username));
		return "factory/user/editPassword";
	}

}
