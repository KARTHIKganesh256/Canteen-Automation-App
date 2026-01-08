<h1 align="center"> Canteen Automation App </h1>

<p align="center">A comprehensive Flutter application designed to streamline canteen operations. Features include user authentication, product management, order placement, recommendations, demand prediction, and admin dashboard for efficient management.</p>

<p align= "center"><img width=70% src="https://github.com/KARTHIKganesh256/Canteen-Automation-App/blob/master/assets/app.png"></p>

<div align="center">

![Forks](https://img.shields.io/github/forks/KARTHIKganesh256/Canteen-Automation-App)
![Stars](https://img.shields.io/github/stars/KARTHIKganesh256/Canteen-Automation-App)
![Issues](https://img.shields.io/github/issues/KARTHIKganesh256/Canteen-Automation-App)
![Pull Requests](https://img.shields.io/github/issues-pr/KARTHIKganesh256/Canteen-Automation-App?)

</div>

<h1 align=center> Tech Stack 🔥 </h1>  
  <p align="center">
  <img src="https://img.shields.io/badge/dart-%230175C2.svg?&style=for-the-badge&logo=dart&logoColor=white"/> <img src="https://img.shields.io/badge/Flutter%20-%2302569B.svg?&style=for-the-badge&logo=Flutter&logoColor=white" /> <img src="https://img.shields.io/badge/Firebase-orange" width=80/> <img src="https://dashboard.razorpay.com/img/logo_full.png" width=80 height=30/>  <img src="https://img.shields.io/badge/github%20-%23121011.svg?&style=for-the-badge&logo=github&logoColor=white"/>
	
<h2 align= "left"><b>Contributing Guidelines!</b></h2>

1. Make sure to keep the UI consistent while adding a new feature.
2. When adding new packages, use the package version which is compatible with the new flutter 2 update.
3. Make sure that your code is well documented, especially in the tougher areas.
4. Maintain a uniform naming convention throughout the codebase.
5. If your code is being repetitive then refactor it to create a new widget for future use.
6. Make the code as modular as possible, separating the UI from the logic.

Contributions are always welcome! You can also visit our [contributing guidelines](https://github.com/KARTHIKganesh256/Canteen-Automation-App/blob/master/CONTRIBUTING.md) beforing making any contributions.

<h2 align= "left"><b>Steps</b></h2>

**1.** Fork [this](https://github.com/KARTHIKganesh256/Canteen-Automation-App) repository.

**2.** Clone the forked repository.

```terminal
git clone https://github.com/<your-github-username>/Canteen-Automation-App.git
```

**3.** Navigate to the project directory.

```terminal
cd Canteen-Automation-App
```

**4.** Create a new branch.

```terminal
git checkout -b <your_branch_name>
```

**5.** Make changes in source code.

**6.** Commit your changes.
```terminal
git commit -m "Message"
```

**7.** Push your local branch to the remote repository.
```terminal
git push -u origin <your_branch_name>
```

**8.** Create a Pull Request!

**Congratulations!!**  :boom: Sit and relax, you've made your contribution to [Canteen Automation App](https://github.com/KARTHIKganesh256/Canteen-Automation-App) project.

<h2 align= "left"><b>Code of Conduct</b></h2>

We follow certain guidelines in order to maintain this repository. Please find our [code of conduct](https://github.com/KARTHIKganesh256/Canteen-Automation-App/blob/master/CODE_OF_CONDUCT.md) and read it carefully.

<h2 align= "left"><b>License</b></h2>

Distributed under the GPL-3.0 License. See [LICENSE](https://github.com/KARTHIKganesh256/Canteen-Automation-App/blob/master/LICENSE) for more information.



## Contributors:
<table>
	<tr>
		<td>
			<a href="https://github.com/KARTHIKganesh256/Canteen-Automation-App/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=KARTHIKganesh256/Canteen-Automation-App" />
</a>
		</td>
	</tr>
</table>

---

## API testing (local)

Quick smoke-test script to verify your model endpoints locally. From the project root:

```bash
# Make executable the first time
chmod +x ./scripts/test_api.sh

# Run against localhost (default)
./scripts/test_api.sh

# Or point to emulator / device / remote server
BASE_URL=http://10.0.2.2:8000 ./scripts/test_api.sh
```

If you get non-200 responses or JSON that differs from the expected schema, paste the output here and I will update the client and models.

---

## Web preview (open screens directly)

You can run the app on the web and open the new screens directly in the browser:

1. Start the web server:

```bash
# Default port 8080
flutter run -d web-server --web-port=8080
```

2. Open these direct URLs in your browser (hash routing):

- Recommendations: http://127.0.0.1:8080/#/recommendations
- Predict Demand: http://127.0.0.1:8080/#/predict-demand

Notes:
- If you run the web server on a remote host, replace 127.0.0.1 with the host IP.
- For quick testing on emulator/device, you may prefer `flutter run -d chrome` or `flutter run -d edge`.
- If you need to change the base API URL for the preview, edit `lib/Services/api_config.dart` (set to `http://10.0.2.2:8000` for Android emulator).






